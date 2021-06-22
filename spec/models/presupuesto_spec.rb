require 'rails_helper'

RSpec.describe Presupuesto, type: :model do
  let(:facultad_1) { create(:facultad) }
  let(:facultad_2) { create(:facultad) }
  let(:grupo_1) { create(:grupo, facultad: facultad_1) }
  let(:grupo_2) { create(:grupo, facultad: facultad_2) }
  let(:investigador) { create(:investigador) }
  let(:rubro_1) { create(:rubro) }
  let(:rubro_2) { create(:rubro, nombre: "Rubro 2") }
  let(:rubro_3) { create(:rubro, nombre: "Rubro 3") }
  let(:proyecto_1) { create(:proyecto, facultad: facultad_1, grupo: grupo_1, investigador: investigador) }
  let(:proyecto_2) { create(:proyecto, facultad: facultad_2, grupo: grupo_2, investigador: investigador) }
  let(:presupuesto_1) { create(:presupuesto, proyecto: proyecto_1, rubro: rubro_1, valor_inicial: 10000000.0, reserva: 0.0, egreso: 5000000.0) }
  let(:presupuesto_2) { create(:presupuesto, proyecto: proyecto_2, rubro: rubro_1, valor_inicial: 40000000.0, reserva: 0.0, egreso: 20000000.0) }
  let(:presupuesto_3) { create(:presupuesto, proyecto: proyecto_1, rubro: rubro_2, valor_inicial: 1000000.0, reserva: 500000.0, egreso: 0.0) }
  let(:presupuesto_4) { create(:presupuesto, proyecto: proyecto_2, rubro: rubro_3, valor_inicial: 2000000.0, reserva: 200000.0, egreso: 0.0) }

  describe 'associations' do
    it { should belong_to(:rubro) }
    it { should belong_to(:proyecto) }
  end

  describe '.por_facultad' do
    
    context "when there's data" do
      before do
        presupuesto_1
        presupuesto_2
        presupuesto_3
        presupuesto_4
      end
  
      let(:expected) do
        [
          {
            anio_inicio: 0,
            disponibilidad_total: 0.0,
            id: facultad_1.id,
            nombre_facultad: facultad_1.nombre,
            egreso_total: 5000000.0,
            presupuesto_inicial: 11000000,
            reserva_total: 500000.0
          },
          {
            anio_inicio: 0,
            disponibilidad_total: 0.0,
            id: facultad_2.id,
            nombre_facultad: facultad_2.nombre,
            egreso_total: 20000000.0,
            presupuesto_inicial: 42000000,
            reserva_total: 200000.0
          }
        ]
      end 
  
      it 'returns presupuestos grouped by facultad' do
        results = described_class.por_facultad.map(&:symbolize_keys)
        expect(results).to match_array expected
      end
    end

    context "when there's no data" do
      it "returns empty array" do
        expect(described_class.por_facultad).to be_empty
      end
    end
  end

  describe '.por_grupo' do

    context "when there's data" do
      before do
        presupuesto_1
        presupuesto_2
        presupuesto_3
        presupuesto_4
      end
      let(:expected) do
        [
          {
            id: grupo_1.id,
            nombre_grupo: grupo_1.nombre,
            disponibilidad_total: 0.0,
            egreso_total: 5000000.0,
            reserva_total: 500000.0,
            presupuesto_inicial: 11000000.0,
            anio_inicio: 0
          },
          {
            id: grupo_2.id,
            nombre_grupo: grupo_2.nombre,
            disponibilidad_total: 0.0,
            egreso_total: 20000000.0,
            reserva_total: 200000.0,
            presupuesto_inicial: 42000000.0,
            anio_inicio: 0
          }
        ]
      end 
  
      it 'returns presupuestos grouped by grupo' do
        results = described_class.por_grupo.map(&:symbolize_keys)
        expect(results).to match_array expected
      end
    end

    context "when there's no data" do
      it "returns empty array" do
        expect(described_class.por_grupo).to be_empty
      end
    end

  end

  describe '.por_rubro' do

    context "when there's data" do
      before do
        presupuesto_1
        presupuesto_2
        presupuesto_3
        presupuesto_4
      end
      let(:expected) do
        [
          {
            id: rubro_1.id,
            nombre_rubro: rubro_1.nombre,
            disponibilidad_total: 0.0,
            egreso_total: 25000000.0,
            reserva_total: 0.0,
            presupuesto_inicial: 50000000.0,
            anio_inicio: 0
          },
          {
            id: rubro_2.id,
            nombre_rubro: rubro_2.nombre,
            disponibilidad_total: 0.0,
            egreso_total: 0.0,
            reserva_total: 500000.0,
            presupuesto_inicial: 1000000.0,
            anio_inicio: 0
          },
          {
            id: rubro_3.id,
            nombre_rubro: rubro_3.nombre,
            disponibilidad_total: 0.0,
            egreso_total: 0.0,
            reserva_total: 200000.0,
            presupuesto_inicial: 2000000.0,
            anio_inicio: 0
          }
        ]
      end 
  
      it 'returns presupuestos grouped by rubro' do
        results = described_class.por_rubro.map(&:symbolize_keys)
        expect(results).to match_array expected
      end
    end

    context "when there's no data" do
      it "returns empty array" do
        expect(described_class.por_rubro).to be_empty
      end
    end

  end

  describe '.por_anio' do

    context "when there's data" do
      before do
        presupuesto_1
        presupuesto_2
        presupuesto_3
        presupuesto_4
      end
      let(:expected) do
        [
          {
            anio_inicio: Time.now.year,
            disponibilidad_total: 0.0,
            egreso_total: 25000000.0,
            reserva_total: 700000.0,
            presupuesto_inicial: 53000000.0
          }
        ]
      end 
  
      it 'returns presupuestos grouped by año' do
        results = described_class.por_anio.map(&:symbolize_keys)
        expect(results).to match_array expected
      end
    end

    context "when there's no data" do
      it "returns empty array" do
        expect(described_class.por_anio).to be_empty
      end
    end

  end

end
