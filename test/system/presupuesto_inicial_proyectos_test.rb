require "application_system_test_case"

class PresupuestoInicialProyectosTest < ApplicationSystemTestCase
  setup do
    @presupuesto_inicial_proyecto = presupuesto_inicial_proyectos(:one)
  end

  test "visiting the index" do
    visit presupuesto_inicial_proyectos_url
    assert_selector "h1", text: "Presupuesto Inicial Proyectos"
  end

  test "creating a Presupuesto inicial proyecto" do
    visit presupuesto_inicial_proyectos_url
    click_on "New Presupuesto Inicial Proyecto"

    fill_in "Descripcion", with: @presupuesto_inicial_proyecto.descripcion
    fill_in "Proyecto", with: @presupuesto_inicial_proyecto.proyecto_id
    fill_in "Rubro", with: @presupuesto_inicial_proyecto.rubro_id
    fill_in "Valor inicial", with: @presupuesto_inicial_proyecto.valor_inicial
    click_on "Create Presupuesto inicial proyecto"

    assert_text "Presupuesto inicial proyecto was successfully created"
    click_on "Back"
  end

  test "updating a Presupuesto inicial proyecto" do
    visit presupuesto_inicial_proyectos_url
    click_on "Edit", match: :first

    fill_in "Descripcion", with: @presupuesto_inicial_proyecto.descripcion
    fill_in "Proyecto", with: @presupuesto_inicial_proyecto.proyecto_id
    fill_in "Rubro", with: @presupuesto_inicial_proyecto.rubro_id
    fill_in "Valor inicial", with: @presupuesto_inicial_proyecto.valor_inicial
    click_on "Update Presupuesto inicial proyecto"

    assert_text "Presupuesto inicial proyecto was successfully updated"
    click_on "Back"
  end

  test "destroying a Presupuesto inicial proyecto" do
    visit presupuesto_inicial_proyectos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Presupuesto inicial proyecto was successfully destroyed"
  end
end
