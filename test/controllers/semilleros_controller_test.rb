require "test_helper"

class SemillerosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @semillero = semilleros(:one)
  end

  test "should get index" do
    get semilleros_url
    assert_response :success
  end

  test "should get new" do
    get new_semillero_url
    assert_response :success
  end

  test "should create semillero" do
    assert_difference('Semillero.count') do
      post semilleros_url, params: { semillero: { descripcion: @semillero.descripcion, grupo_id: @semillero.grupo_id, nombre: @semillero.nombre } }
    end

    assert_redirected_to semillero_url(Semillero.last)
  end

  test "should show semillero" do
    get semillero_url(@semillero)
    assert_response :success
  end

  test "should get edit" do
    get edit_semillero_url(@semillero)
    assert_response :success
  end

  test "should update semillero" do
    patch semillero_url(@semillero), params: { semillero: { descripcion: @semillero.descripcion, grupo_id: @semillero.grupo_id, nombre: @semillero.nombre } }
    assert_redirected_to semillero_url(@semillero)
  end

  test "should destroy semillero" do
    assert_difference('Semillero.count', -1) do
      delete semillero_url(@semillero)
    end

    assert_redirected_to semilleros_url
  end
end
