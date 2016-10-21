class Manager::PatientsController < ApplicationController
  layout 'manager'

  def index
    patients = Patient.all.page(params[:page]).per(15)
    patients_data = patients.map {|x|
      DataFormer.new(x).data
    }

    @component_name = 'manager_patients'
    @component_data = {
      patients: patients_data,
      paginate: DataFormer.paginate_data(patients),
      search_url: manager_search_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '患者档案'
    }
  end

  def show
    patient = Patient.find params[:id]

    @component_name = 'manager_patient_show'
    @component_data = {
      patient: DataFormer.new(patient)
        .logic(:records_count)
        .logic(:active_record)
        .data,
    }
    @extend_nav_data = {
      mobile_back_to: manager_patients_path,
      current_title: "患者档案：#{patient.name}"
    }
  end

  def edit
    patient = Patient.find params[:id]

    @component_name = 'manager_patient_edit'
    @component_data = {
      patient: DataFormer.new(patient)
        .logic(:records_count)
        .logic(:active_record)
        .data,
    }
    @extend_nav_data = {
      mobile_back_to: manager_patient_path(patient),
      current_title: "患者档案：#{patient.name}"
    }
  end

  def records_info
    patient = Patient.find params[:id]

    @component_name = 'manager_patient_records'
    @component_data = {
      patient: DataFormer.new(patient)
        .logic(:records_count)
        .logic(:active_record)
        .logic(:records)
        .data
    }
    @extend_nav_data = {
      mobile_back_to: manager_patients_path,
      current_title: "就诊记录：#{patient.name}"
    }
  end

  def active_record_info
    patient = Patient.find params[:id]

    @component_name = 'manager_patient_active_record_info'
    @component_data = {
      patient: DataFormer.new(patient)
        .logic(:records_count)
        .logic(:active_record)
        .data
    }
    @extend_nav_data = {
      mobile_back_to: manager_patients_path,
      current_title: "挂号信息：#{patient.name}"
    }
  end

end