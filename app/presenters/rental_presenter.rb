class RentalPresenter < SimpleDelegator
#   attr_reader :rental
#   # delegate :client, to: :rental

#   def initialize(rental)
#     # @rental = rental
#     super(rental)
#   end

  
#   def status
#     # if rental.scheduled?
#     if scheduled?
#       h.content_tag :span, class: "badge badge-primary" do
#         'agendada'
#       end
#     end
#   end

#    private
  
#    def h
#     ApplicationController.helpers
#    end
  
#   # def method_missing(method, *args, &block)
#   #   rental.public_send(method, *args, &block)
#   # end

#   # def respond_to?(method_name, include_private = false)
#   #   rental.respond_to? method_name, include_private
#   # end
# end
  include Rails.application.routes.url_helpers #para incuir o path
  delegate :content_tag, :link_to, to: :helper

  attr_reader :user, :authorizer

  def initialize(rental, user, authorizer = RentalActionsAuthorizer)
    super(rental)
    @user = user
    @authorizer = authorizer
  end

  def status_badge
    content_tag :span, class: "badge badge-#{status_class}" do
      I18n.translate(status.to_s)
    end
  end

  def current_action
    return '' unless authorizer.new(__getobj__, user).authorized?
    if scheduled?
      link_to 'Iniciar Locação', review_rental_path(id)
    
    elsif ongoing?
      link_to 'Encerrar Locação', closure_review_rental_path(id)
    
    elsif in_review?
      link_to 'Continuar Locação', review_rental_path(id)
    elsif finalized? && user.admin?
      link_to 'Reportar Problema', report_rental_path(id)
    else 
      ''
    end
  end

  private

  def helper
    ApplicationController.helpers
  end

  def status_class
    status_classes = {
      scheduled: 'primary',
      ongoing: 'info',
      in_review: '',
      finalized: 'success'
    }

    status_classes[status.to_sym]
  end
end
