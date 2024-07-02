require "application_system_test_case"

class PollsTest < ApplicationSystemTestCase
  setup do
    @poll = polls(:one)
  end

  test "visiting the index" do
    visit polls_url
    assert_selector "h1", text: "Polls"
  end

  test "should create poll" do
    visit polls_url
    click_on "New poll"

    fill_in "Event", with: @poll.event_id
    fill_in "Title", with: @poll.title
    click_on "Create Poll"

    assert_text "Poll was successfully created"
    click_on "Back"
  end

  test "should update Poll" do
    visit poll_url(@poll)
    click_on "Edit this poll", match: :first

    fill_in "Event", with: @poll.event_id
    fill_in "Title", with: @poll.title
    click_on "Update Poll"

    assert_text "Poll was successfully updated"
    click_on "Back"
  end

  test "should destroy Poll" do
    visit poll_url(@poll)
    click_on "Destroy this poll", match: :first

    assert_text "Poll was successfully destroyed"
  end
end
