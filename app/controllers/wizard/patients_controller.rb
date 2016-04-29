class Wizard::PatientsController < ApplicationController
  layout 'manager'

  def index
    patients = Patient.all.page(params[:page]).per(15)
    patients_data = patients.map {|x|
      DataFormer.new(x).data
    }

    @page_name = 'wizard_patients'
    @component_data = {
      patients: patients_data,
      paginate: DataFormer.paginate_data(patients),
      search_url: wizard_search_path
    }
    @extend_nav_data = {
      mobile_back_to: wizard_path,
      current_title: '患者档案'
    }
  end

  def new
    @page_name = 'wizard_patients_new'
    @component_data = {
      submit_url: wizard_patients_path,
      cancel_url: wizard_path
    }
    @extend_nav_data = {
      mobile_back_to: wizard_path,
      current_title: '患者登记'
    }
  end

  def create
    patient = Patient.new patient_params
    save_model(patient) do |_patient|
      DataFormer.new(_patient)
        .data
    end
  end

  def show
    patient = Patient.find params[:id]

    @page_name = 'wizard_patient_show'
    @component_data = {
      patient: DataFormer.new(patient).data
    }
    @extend_nav_data = {
      mobile_back_to: wizard_patients_path,
      current_title: "患者档案：#{patient.name}"
    }
  end

  private

  def patient_params
    params.require(:patient).permit(:name, :id_card, :mobile_phone, :symptom_desc, :personal_pathography, :family_pathography)
  end
end