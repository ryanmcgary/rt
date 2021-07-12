require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invalid_record = links(:invalid_link)
    @valid_record = links(:valid_link)
    @inactive_record = links(:inactive_link)
  end

  test "shouldn't get index" do
    assert_raises(ActionController::RoutingError) do
      get links_url
    end
  end
  
  test "should redirect shortlink" do
    get redirection_url(Hashid.encode(@valid_record.id))
    assert_redirected_to @valid_record.url
  end

  test "should throw 404 on NON active link" do
    assert_raises(ActionController::RoutingError) do
      get redirection_url(Hashid.encode(@inactive_record.id))
    end
  end

  test "should create link" do
    assert_difference('Link.count') do
      post links_url, params: { link: { url: @valid_record.url } }
    end

    assert_redirected_to link_admin_path(Link.last.admin_id)
  end

  test "should increment link view_count on redirect" do
    get redirection_url(Hashid.encode(@valid_record.id))
    assert_equal(2, Link.find(@valid_record.id).view_count)
  end

  test "should get new" do
    get new_link_url
    assert_response :success
  end

  test "should show link" do
    get link_admin_path(@invalid_record.admin_id)
    assert_response :success
  end

  test "should get edit" do
    get link_admin_path(@invalid_record.admin_id)
    assert_response :success
  end

  test "should update link" do
    patch link_url(@valid_record.admin_id), params: { link: { active: false } }
    assert_redirected_to link_admin_path(@valid_record.admin_id)
  end

end
