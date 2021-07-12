require "application_system_test_case"

class LinksTest < ApplicationSystemTestCase
  setup do
    @link = links(:one)
  end

  test "visiting the index" do
    visit links_url
    assert_selector "h1", text: "Links"
  end

  test "creating a Link" do
    visit links_url
    click_on "New Link"

    check "Active" if @link.active
    fill_in "Admin", with: @link.admin_id
    fill_in "Id", with: @link.id
    fill_in "Url", with: @link.url
    fill_in "View count", with: @link.view_count
    click_on "Create Link"

    assert_text "Link was successfully created"
    click_on "Back"
  end

  test "updating a Link" do
    visit links_url
    click_on "Edit", match: :first

    check "Active" if @link.active
    fill_in "Admin", with: @link.admin_id
    fill_in "Id", with: @link.id
    fill_in "Url", with: @link.url
    fill_in "View count", with: @link.view_count
    click_on "Update Link"

    assert_text "Link was successfully updated"
    click_on "Back"
  end

  test "destroying a Link" do
    visit links_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Link was successfully destroyed"
  end
end
