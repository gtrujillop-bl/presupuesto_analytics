require "test_helper"

class ProyectosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proyecto = proyectos(:one)
  end

  test "should get index" do
    get proyectos_url
    assert_response :success
  end

  test "should get new" do
    get new_proyecto_url
    assert_response :success
  end

  test "should create proyecto" do
    assert_difference('Proyecto.count') do
      post proyectos_url, params: { proyecto: { facultad_id: @proyecto.facultad_id, fecha_fin: @proyecto.fecha_fin, fecha_inicio: @proyecto.fecha_inicio, grupo_id: @proyecto.grupo_id, investigador_id: @proyecto.investigador_id, nombre: @proyecto.nombre, numero_proyecto: @proyecto.numero_proyecto, semillero_id: @proyecto.semillero_id } }
    end

    assert_redirected_to proyecto_url(Proyecto.last)
  end

  test "should show proyecto" do
    get proyecto_url(@proyecto)
    assert_response :success
  end

  test "should get edit" do
    get edit_proyecto_url(@proyecto)
    assert_response :success
  end

  test "should update proyecto" do
    patch proyecto_url(@proyecto), params: { proyecto: { facultad_id: @proyecto.facultad_id, fecha_fin: @proyecto.fecha_fin, fecha_inicio: @proyecto.fecha_inicio, grupo_id: @proyecto.grupo_id, investigador_id: @proyecto.investigador_id, nombre: @proyecto.nombre, numero_proyecto: @proyecto.numero_proyecto, semillero_id: @proyecto.semillero_id } }
    assert_redirected_to proyecto_url(@proyecto)
  end

  test "should destroy proyecto" do
    assert_difference('Proyecto.count', -1) do
      delete proyecto_url(@proyecto)
    end

    assert_redirected_to proyectos_url
  end
end
