class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:bulletin1)
  end

  test 'should get index' do
    get bulletins_url
    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'should show bulletin' do
    get bulletin_url(@bulletin)
    assert_response :success
    assert_select 'h1', @bulletin.title
    assert_select 'p', @bulletin.body
    assert_equal true, @bulletin.published
  end
end
