require 'rails_helper'

feature 'Admin registers multiple rental prices' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    address = create(:address, street: 'Av. Paulista', number: '100', 
      neighborhood: 'Cerqueira César', city: 'São Paulo', state: 'SP', subsidiary: subsidiary)
    user = create(:user, role: :admin)
    create(:category, name: 'A')
    create(:category, name: 'B')

    login_as user, scope: :user
    visit root_path
    click_on 'Configurar preços de locações'
    click_on 'Rent a Car'

    find('.rental_price0 .daily_rate').set('50.0')
    find('.rental_price0 .car_insurance').set('80.0')
    find('.rental_price0 .third_party_insurance').set('75.0')
    # within('.rental_price0') do
    #  fill_in ".daily_rate", with: '50.00'
    #  fill_in 'car_insurance', with: '80.00'
    #  fill_in 'third_party_insurance', with: '75.00'
    # end

    within('.rental_price1') do
      find(:css, '.daily_rate').set('54.70')
      find(:css, '.car_insurance').set('56.50')
      find(:css, '.third_party_insurance').set('43.10')
    end

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Configurar preços de locações')
    expect(page).to have_css('th', text: 'Categoria')
    expect(page).to have_css('th', text: 'Diária')
    expect(page).to have_css('th', text: 'Seguro do carro')
    expect(page).to have_css('th', text: 'Seguro contra terceiros')

    within('.rental_price0') do
      expect(page).to have_css('td', text: 'R$ 50.0')
      expect(page).to have_css('td', text: 'R$ 80.0')
      expect(page).to have_css('td', text: 'R$ 75.0')
    end

    within('.rental_price1') do
      expect(page).to have_css('td', text: 'R$ 54.7')
      expect(page).to have_css('td', text: 'R$ 56.5')
      expect(page).to have_css('td', text: 'R$ 43.1')
    end
  end

  scenario 'and must fill all fields' do
    subsidiary = create(:subsidiary, name: 'Rent a Car')
    address = create(:address, street: 'Av. Paulista', number: '100',
                     neighborhood: 'Cerqueira César', city: 'São Paulo',
                     state: 'SP', subsidiary: subsidiary)
    user = create(:user, role: :admin)
    create(:category, name: 'A')
    create(:category, name: 'B')

    login_as user, scope: :user
    visit root_path
    click_on 'Configurar preços de locações'
    click_on 'Rent a Car'

    within('.rental_price0') do
      find(:css, '.daily_rate').set('50.00')
      find(:css, '.car_insurance').set('80.00')
      find(:css, '.third_party_insurance').set('75.00')
    end

    within('.rental_price1') do
      find(:css, '.daily_rate').set('')
      find(:css, '.car_insurance').set('')
      find(:css, '.third_party_insurance').set('')
    end

    click_on 'Enviar'

    expect(page).to have_content('Diária não pode ficar em branco')
    expect(page).to have_content('Seguro do carro não pode ficar em branco')
    expect(page).to have_content('Seguro contra terceiros não pode ficar em '\
                                 'branco')
  end
end
