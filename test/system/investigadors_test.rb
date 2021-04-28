require "application_system_test_case"

class InvestigadorsTest < ApplicationSystemTestCase
  setup do
    @investigador = investigadors(:one)
  end

  test "visiting the index" do
    visit investigadors_url
    assert_selector "h1", text: "Investigadors"
  end

  test "creating a Investigador" do
    visit investigadors_url
    click_on "New Investigador"

    fill_in "Apellidos", with: @investigador.apellidos
    fill_in "Cedula", with: @investigador.cedula
    fill_in "Nombres", with: @investigador.nombres
    click_on "Create Investigador"

    assert_text "Investigador was successfully created"
    click_on "Back"
  end

  test "updating a Investigador" do
    visit investigadors_url
    click_on "Edit", match: :first

    fill_in "Apellidos", with: @investigador.apellidos
    fill_in "Cedula", with: @investigador.cedula
    fill_in "Nombres", with: @investigador.nombres
    click_on "Update Investigador"

    assert_text "Investigador was successfully updated"
    click_on "Back"
  end

  test "destroying a Investigador" do
    visit investigadors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Investigador was successfully destroyed"
  end
end
