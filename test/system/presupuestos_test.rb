require "application_system_test_case"

class PresupuestosTest < ApplicationSystemTestCase
  setup do
    @presupuesto = presupuestos(:one)
  end

  test "visiting the index" do
    visit presupuestos_url
    assert_selector "h1", text: "Presupuestos"
  end

  test "creating a Presupuesto" do
    visit presupuestos_url
    click_on "New Presupuesto"

    fill_in "Descripcion", with: @presupuesto.descripcion
    fill_in "Disponibilidad", with: @presupuesto.disponibilidad
    fill_in "Egreso", with: @presupuesto.egreso
    fill_in "Proyecto", with: @presupuesto.proyecto_id
    fill_in "Reserva", with: @presupuesto.reserva
    fill_in "Rubro", with: @presupuesto.rubro_id
    fill_in "Valor inicial", with: @presupuesto.valor_inicial
    click_on "Create Presupuesto"

    assert_text "Presupuesto was successfully created"
    click_on "Back"
  end

  test "updating a Presupuesto" do
    visit presupuestos_url
    click_on "Edit", match: :first

    fill_in "Descripcion", with: @presupuesto.descripcion
    fill_in "Disponibilidad", with: @presupuesto.disponibilidad
    fill_in "Egreso", with: @presupuesto.egreso
    fill_in "Proyecto", with: @presupuesto.proyecto_id
    fill_in "Reserva", with: @presupuesto.reserva
    fill_in "Rubro", with: @presupuesto.rubro_id
    fill_in "Valor inicial", with: @presupuesto.valor_inicial
    click_on "Update Presupuesto"

    assert_text "Presupuesto was successfully updated"
    click_on "Back"
  end

  test "destroying a Presupuesto" do
    visit presupuestos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Presupuesto was successfully destroyed"
  end
end
