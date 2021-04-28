require "application_system_test_case"

class ProyectosTest < ApplicationSystemTestCase
  setup do
    @proyecto = proyectos(:one)
  end

  test "visiting the index" do
    visit proyectos_url
    assert_selector "h1", text: "Proyectos"
  end

  test "creating a Proyecto" do
    visit proyectos_url
    click_on "New Proyecto"

    fill_in "Facultad", with: @proyecto.facultad_id
    fill_in "Fecha fin", with: @proyecto.fecha_fin
    fill_in "Fecha inicio", with: @proyecto.fecha_inicio
    fill_in "Grupo", with: @proyecto.grupo_id
    fill_in "Investigador", with: @proyecto.investigador_id
    fill_in "Nombre", with: @proyecto.nombre
    fill_in "Numero proyecto", with: @proyecto.numero_proyecto
    fill_in "Semillero", with: @proyecto.semillero_id
    click_on "Create Proyecto"

    assert_text "Proyecto was successfully created"
    click_on "Back"
  end

  test "updating a Proyecto" do
    visit proyectos_url
    click_on "Edit", match: :first

    fill_in "Facultad", with: @proyecto.facultad_id
    fill_in "Fecha fin", with: @proyecto.fecha_fin
    fill_in "Fecha inicio", with: @proyecto.fecha_inicio
    fill_in "Grupo", with: @proyecto.grupo_id
    fill_in "Investigador", with: @proyecto.investigador_id
    fill_in "Nombre", with: @proyecto.nombre
    fill_in "Numero proyecto", with: @proyecto.numero_proyecto
    fill_in "Semillero", with: @proyecto.semillero_id
    click_on "Update Proyecto"

    assert_text "Proyecto was successfully updated"
    click_on "Back"
  end

  test "destroying a Proyecto" do
    visit proyectos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Proyecto was successfully destroyed"
  end
end
