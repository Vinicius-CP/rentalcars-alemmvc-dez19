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

  delegate :content_tag, to: :helper

  def initialize(rental)
    super(rental)
  end

  def status_badge
    content_tag :span, class: "badge badge-#{status_class}" do
      I18n.translate(status.to_s)
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
