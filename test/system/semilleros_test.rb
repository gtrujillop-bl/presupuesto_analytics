require "application_system_test_case"

class SemillerosTest < ApplicationSystemTestCase
  setup do
    @semillero = semilleros(:one)
  end

  test "visiting the index" do
    visit semilleros_url
    assert_selector "h1", text: "Semilleros"
  end

  test "creating a Semillero" do
    visit semilleros_url
    click_on "New Semillero"

    fill_in "Descripcion", with: @semillero.descripcion
    fill_in "Grupo", with: @semillero.grupo_id
    fill_in "Nombre", with: @semillero.nombre
    click_on "Create Semillero"

    assert_text "Semillero was successfully created"
    click_on "Back"
  end

  test "updating a Semillero" do
    visit semilleros_url
    click_on "Edit", match: :first

    fill_in "Descripcion", with: @semillero.descripcion
    fill_in "Grupo", with: @semillero.grupo_id
    fill_in "Nombre", with: @semillero.nombre
    click_on "Update Semillero"

    assert_text "Semillero was successfully updated"
    click_on "Back"
  end

  test "destroying a Semillero" do
    visit semilleros_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Semillero was successfully destroyed"
  end
end
