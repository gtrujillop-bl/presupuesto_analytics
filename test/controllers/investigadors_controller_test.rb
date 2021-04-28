require "test_helper"

class InvestigadorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @investigador = investigadors(:one)
  end

  test "should get index" do
    get investigadors_url
    assert_response :success
  end

  test "should get new" do
    get new_investigador_url
    assert_response :success
  end

  test "should create investigador" do
    assert_difference('Investigador.count') do
      post investigadors_url, params: { investigador: { apellidos: @investigador.apellidos, cedula: @investigador.cedula, nombres: @investigador.nombres } }
    end

    assert_redirected_to investigador_url(Investigador.last)
  end

  test "should show investigador" do
    get investigador_url(@investigador)
    assert_response :success
  end

  test "should get edit" do
    get edit_investigador_url(@investigador)
    assert_response :success
  end

  test "should update investigador" do
    patch investigador_url(@investigador), params: { investigador: { apellidos: @investigador.apellidos, cedula: @investigador.cedula, nombres: @investigador.nombres } }
    assert_redirected_to investigador_url(@investigador)
  end

  test "should destroy investigador" do
    assert_difference('Investigador.count', -1) do
      delete investigador_url(@investigador)
    end

    assert_redirected_to investigadors_url
  end
end
