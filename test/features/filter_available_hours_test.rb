require 'test_helper'

feature 'Should be able filter prospects on available hours per week' do
  scenario 'login as user & filter', js: true do
    page.current_window.resize_to(2048, 2048)

    User.create(cas_directory_id: 'filterer', name: 'filterer', admin: false)
    visit prospects_path
    fill_in 'username', with: 'filterer'
    fill_in 'password', with: 'any password'
    click_button 'Login'

    # Our Students....
    Prospect.find_by( first_name: "Betty" ).update_attribute( :available_hours_per_week,  15 )
    Prospect.find_by( first_name: "Alvin" ).update_attribute( :available_hours_per_week, 1 )
    Prospect.find_by( first_name: "Rolling" ).update_attribute( :available_hours_per_week,  40 )

    # We should have all of our students present
    assert page.has_content?("Student, Betty")
    assert page.has_content?("Student, Alvin")
    assert page.has_content?("Stone, Rolling")

    find("#filter-prospects").click
    assert page.has_content?('Filter Applications')

    # we tweak the slider...
    min = drag_until('.min-slider-handle', by: 10) { |v| v > 1 }
    max = drag_until('.max-slider-handle', by: -100) { |v| v < 40 }
    sleep(2)
    find("#submit-filter").click

    # But only Betty has hours in the  range
    assert page.has_content?("Student, Betty")
    refute page.has_content?("Student, Alvin")
    refute page.has_content?("Stone, Rolling")

  end
end
