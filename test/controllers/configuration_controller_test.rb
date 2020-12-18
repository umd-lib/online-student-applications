# frozen_string_literal: true

require 'test_helper'

class ConfigurationControllerTest < ActionController::TestCase
  test 'should not create a new enumeration for non-users' do
    assert_no_difference('Enumeration.count') do
      post :update, params: { enumeration: { list_id: 0, value: 'phd' } }
    end
    assert_response(401)
  end

  test 'should create a new enumeration' do
    session[:cas] = { user: 'admin' }
    assert_difference('Enumeration.count') do
      post :update, params: { enumeration: { list_id: 0, value: 'phd' } }
    end
    assert_response(200)
  end

  test 'should update the enumeration positions' do
    session[:cas] = { user: 'admin' }
    cs = Enumeration.active_class_statuses.map(&:id).reverse
    assert_not_equal cs, Enumeration.active_class_statuses.map(&:id)
    post :update, params: { update_positions_ids: cs }
    assert_response(200)
    assert_equal cs, Enumeration.active_class_statuses.map(&:id)
  end

  test 'should toggle the enumeration active bool' do
    session[:cas] = { user: 'admin' }
    cs = Enumeration.active_class_statuses.first
    assert cs.active?
    post :update, params: { toggle_active_id: cs.id }
    assert_response(200)
    assert_not cs.reload.active?
    post :update, params: { toggle_active_id: cs.id }
    assert_response(200)
    assert cs.reload.active?
  end

  test 'should create a new skill' do
    session[:cas] = { user: 'admin' }
    assert_difference('Skill.count') do
      post :update, params: { skill: { name: 'basket weaving' } }
    end
    assert_response(200)
  end

  test 'should toggle the skills promoted bool' do
    session[:cas] = { user: 'admin' }
    skill = Skill.promoted.first
    assert skill.promoted?
    post :update, params: { toggle_promoted_id: skill.id }
    assert_response(200)
    assert_not skill.reload.promoted?
    post :update, params: { toggle_promoted_id: skill.id }
    assert_response(200)
    assert skill.reload.promoted?
  end

  test 'if I sumbit something wack it should give me back the error' do
    session[:cas] = { user: 'admin' }
    post :update, params: { toggle_promoted_id: 100_000_000 }
    assert_response(400)
    assert JSON.parse(response.body).key?('error')
  end
end
