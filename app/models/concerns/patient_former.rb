module PatientFormer
  extend ActiveSupport::Concern

  included do

    former "Patient" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :id_card
      field :mobile_phone
      field :symptom_desc
      field :personal_pathography
      field :family_pathography

      field :wizard_show_url, ->(instance) {
        wizard_patient_path(instance)
      }
    end

  end
end
