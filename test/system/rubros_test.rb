require "application_system_test_case"

class RubrosTest < ApplicationSystemTestCase
  setup do
    @rubro = rubros(:one)
  end

  test "visiting the index" do
    visit rubros_url
    assert_selector "h1", text: "Rubros"
  end

  test "creating a Rubro" do
    visit rubros_url
    click_on "New Rubro"

    fill_in "Descripcion", with: @rubro.descripcion
    fill_in "Nombre", with: @rubro.nombre
    click_on "Create Rubro"

    assert_text "Rubro was successfully created"
    click_on "Back"
  end

  test "updating a Rubro" do
    visit rubros_url
    click_on "Edit", match: :first

    fill_in "Descripcion", with: @rubro.descripcion
    fill_in "Nombre", with: @rubro.nombre
    click_on "Update Rubro"

    assert_text "Rubro was successfully updated"
    click_on "Back"
  end

  test "destroying a Rubro" do
    visit rubros_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rubro was successfully destroyed"
  end
end
