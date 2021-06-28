require "rails_helper"

RSpec.describe PresupuestosController, type: :controller do
  let(:facultad_1) { create(:facultad) }
  let(:grupo_1) { create(:grupo, facultad: facultad_1) }
  let(:investigador) { create(:investigador) }
  let(:rubro_1) { create(:rubro, nombre: "Viajes") }
  let(:rubro_2) { create(:rubro, nombre: "Otros") }
  let(:proyecto_1) { create(:proyecto, facultad: facultad_1, grupo: grupo_1, investigador: investigador, numero_proyecto: '4000000231-19') }

  describe "POST #import" do
    before do
      rubro_1
      rubro_2
      proyecto_1
    end
  
    context 'when file is provided' do
      before do
        post :import, params: { file: Rack::Test::UploadedFile.new(file, 'text/csv') }
      end
      
      context "when is a valid file" do
        let(:file) { File.join(Rails.root, 'spec', 'fixtures', 'data_valid.csv') }

        it "should be able to upload file" do
          ids = Presupuesto.pluck(:id)
          expect(response).to redirect_to presupuestos_path(ids: ids)
        end

        it "adds a flash notice" do
          expect(flash[:notice]).to eq "Presupuestos cargados correctamente"
        end
      end

      context "when a rubro don't exist" do
        let(:file) { File.join(Rails.root, 'spec', 'fixtures', 'data_rubro_not_valid.csv') }
        let(:rubro) { "Publicidad" }

        it "has a 400 status code" do
          expect(response.status).to eq(400)
        end

        it "throws ActiveRecord::RecordNotFound" do
          # ids = Presupuesto.pluck(:id)
          # assert_response :not_found
          expect(response.body).to include("No se encontró rubro: #{rubro}")
        end
      end

      context "when a project don't exist" do
        let(:file) { File.join(Rails.root, 'spec', 'fixtures', 'data_proyecto_not_valid.csv') }
        let(:proyecto) { "4000000231-18" }

        it "has a 400 status code" do
          expect(response.status).to eq(400)
        end

        it "throws ActiveRecord::RecordNotFound" do
          # ids = Presupuesto.pluck(:id)
          # assert_response :not_found
          expect(response.body).to include("No se encontró proyecto: #{proyecto}")
        end
      end
    end
  end

  describe "GET #new_import" do
    it "has a 200 status code" do
      get :new_import
      expect(response.status).to eq(200)
    end
  end
end
