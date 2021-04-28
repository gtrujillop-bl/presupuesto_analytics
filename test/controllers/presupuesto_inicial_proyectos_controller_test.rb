require "test_helper"

class PresupuestoInicialProyectosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @presupuesto_inicial_proyecto = presupuesto_inicial_proyectos(:one)
  end

  test "should get index" do
    get presupuesto_inicial_proyectos_url
    assert_response :success
  end

  test "should get new" do
    get new_presupuesto_inicial_proyecto_url
    assert_response :success
  end

  test "should create presupuesto_inicial_proyecto" do
    assert_difference('PresupuestoInicialProyecto.count') do
      post presupuesto_inicial_proyectos_url, params: { presupuesto_inicial_proyecto: { descripcion: @presupuesto_inicial_proyecto.descripcion, proyecto_id: @presupuesto_inicial_proyecto.proyecto_id, rubro_id: @presupuesto_inicial_proyecto.rubro_id, valor_inicial: @presupuesto_inicial_proyecto.valor_inicial } }
    end

    assert_redirected_to presupuesto_inicial_proyecto_url(PresupuestoInicialProyecto.last)
  end

  test "should show presupuesto_inicial_proyecto" do
    get presupuesto_inicial_proyecto_url(@presupuesto_inicial_proyecto)
    assert_response :success
  end

  test "should get edit" do
    get edit_presupuesto_inicial_proyecto_url(@presupuesto_inicial_proyecto)
    assert_response :success
  end

  test "should update presupuesto_inicial_proyecto" do
    patch presupuesto_inicial_proyecto_url(@presupuesto_inicial_proyecto), params: { presupuesto_inicial_proyecto: { descripcion: @presupuesto_inicial_proyecto.descripcion, proyecto_id: @presupuesto_inicial_proyecto.proyecto_id, rubro_id: @presupuesto_inicial_proyecto.rubro_id, valor_inicial: @presupuesto_inicial_proyecto.valor_inicial } }
    assert_redirected_to presupuesto_inicial_proyecto_url(@presupuesto_inicial_proyecto)
  end

  test "should destroy presupuesto_inicial_proyecto" do
    assert_difference('PresupuestoInicialProyecto.count', -1) do
      delete presupuesto_inicial_proyecto_url(@presupuesto_inicial_proyecto)
    end

    assert_redirected_to presupuesto_inicial_proyectos_url
  end
end
