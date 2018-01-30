# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180130162428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "cnpj"
    t.integer "available_funds_cents", default: 0, null: false
    t.string "available_funds_currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "debt_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "debts", force: :cascade do |t|
    t.bigint "seller_id"
    t.bigint "finantial_institution_id"
    t.bigint "debt_type_id"
    t.integer "total_amount_cents", default: 0, null: false
    t.string "total_amount_currency", default: "BRL", null: false
    t.integer "balance_amount_cents", default: 0, null: false
    t.string "balance_amount_currency", default: "BRL", null: false
    t.integer "installments_quantity"
    t.string "information_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["debt_type_id"], name: "index_debts_on_debt_type_id"
    t.index ["finantial_institution_id"], name: "index_debts_on_finantial_institution_id"
    t.index ["seller_id"], name: "index_debts_on_seller_id"
  end

  create_table "equity_holders", force: :cascade do |t|
    t.bigint "payer_id"
    t.bigint "seller_id"
    t.string "first_name"
    t.string "last_name"
    t.string "cpf"
    t.datetime "birthday"
    t.string "nationality"
    t.string "phone_number"
    t.string "email"
    t.string "total_equity"
    t.string "ordinary_equity"
    t.string "signature"
    t.datetime "partnership_date"
    t.string "zip_code"
    t.string "address"
    t.string "address_number"
    t.string "neigborhood"
    t.string "address_2"
    t.string "state"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payer_id"], name: "index_equity_holders_on_payer_id"
    t.index ["seller_id"], name: "index_equity_holders_on_seller_id"
  end

  create_table "finantial_institutions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "finantials", force: :cascade do |t|
    t.bigint "seller_id"
    t.string "production_economics_cycle_description"
    t.integer "employee_quantity"
    t.integer "total_wages_cost_cents", default: 0, null: false
    t.string "total_wages_cost_currency", default: "BRL", null: false
    t.integer "rent_cost_cents", default: 0, null: false
    t.string "rent_cost_currency", default: "BRL", null: false
    t.integer "relevant_fixed_cost_cents", default: 0, null: false
    t.string "relevant_fixed_cost_currency", default: "BRL", null: false
    t.integer "cost_of_goods_sold_cents", default: 0, null: false
    t.string "cost_of_goods_sold_currency", default: "BRL", null: false
    t.integer "ebitda_cents", default: 0, null: false
    t.string "ebitda_currency", default: "BRL", null: false
    t.string "information_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_finantials_on_seller_id"
  end

  create_table "installments", force: :cascade do |t|
    t.bigint "invoice_id"
    t.string "number"
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "BRL", null: false
    t.datetime "due_date"
    t.integer "outstanding_days"
    t.integer "interest_cents", default: 0, null: false
    t.string "interest_currency", default: "BRL", null: false
    t.integer "ad_valorem_cents", default: 0, null: false
    t.string "ad_valorem_currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_installments_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "invoice_number"
    t.string "contract_number"
    t.string "check_number"
    t.string "status"
    t.string "delivery_status"
    t.boolean "confirmed"
    t.boolean "notified"
    t.boolean "boleto_especial"
    t.integer "average_outstanding_days"
    t.integer "total_value_cents", default: 0, null: false
    t.string "total_value_currency", default: "BRL", null: false
    t.integer "average_interest_cents", default: 0, null: false
    t.string "average_interest_currency", default: "BRL", null: false
    t.integer "average_ad_valorem_cents", default: 0, null: false
    t.string "average_ad_valorem_currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "operation_id"
    t.bigint "payer_id"
    t.string "xml_file_name"
    t.string "xml_content_type"
    t.integer "xml_file_size"
    t.datetime "xml_updated_at"
    t.string "invoice_type"
    t.index ["operation_id"], name: "index_invoices_on_operation_id"
    t.index ["payer_id"], name: "index_invoices_on_payer_id"
  end

  create_table "operations", force: :cascade do |t|
    t.integer "total_value_cents", default: 0, null: false
    t.string "total_value_currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "average_interest_cents", default: 0, null: false
    t.string "average_interest_currency", default: "BRL", null: false
    t.integer "average_ad_valorem_cents", default: 0, null: false
    t.string "average_ad_valorem_currency", default: "BRL", null: false
    t.integer "average_outstanding_days"
    t.integer "fee_instrucoes_bancarias_em_titulos_cents", default: 0, null: false
    t.string "fee_instrucoes_bancarias_em_titulos_currency", default: "BRL", null: false
    t.integer "fee_aditivo_cents", default: 0, null: false
    t.string "fee_aditivo_currency", default: "BRL", null: false
    t.integer "fee_cobranca_custodia_cheques_cents", default: 0, null: false
    t.string "fee_cobranca_custodia_cheques_currency", default: "BRL", null: false
    t.integer "fee_consulta_de_credito_cents", default: 0, null: false
    t.string "fee_consulta_de_credito_currency", default: "BRL", null: false
    t.integer "fee_cobranca_notificacao_duplicatas_cents", default: 0, null: false
    t.string "fee_cobranca_notificacao_duplicatas_currency", default: "BRL", null: false
    t.integer "fee_doc_ted_transferencia_cents", default: 0, null: false
    t.string "fee_doc_ted_transferencia_currency", default: "BRL", null: false
    t.integer "tax_iss_cents", default: 0, null: false
    t.string "tax_iss_currency", default: "BRL", null: false
    t.integer "tax_pis_cents", default: 0, null: false
    t.string "tax_pis_currency", default: "BRL", null: false
    t.integer "tax_cofins_cents", default: 0, null: false
    t.string "tax_cofins_currency", default: "BRL", null: false
    t.integer "tax_retained_pis_cents", default: 0, null: false
    t.string "tax_retained_pis_currency", default: "BRL", null: false
    t.integer "tax_retained_cofins_cents", default: 0, null: false
    t.string "tax_retained_cofins_currency", default: "BRL", null: false
    t.integer "tax_retained_irpj_cents", default: 0, null: false
    t.string "tax_retained_irpj_currency", default: "BRL", null: false
    t.integer "tax_retained_csll_cents", default: 0, null: false
    t.string "tax_retained_csll_currency", default: "BRL", null: false
    t.integer "tax_retained_iof_cents", default: 0, null: false
    t.string "tax_retained_iof_currency", default: "BRL", null: false
    t.integer "advancement_cents", default: 0, null: false
    t.string "advancement_currency", default: "BRL", null: false
    t.integer "tax_ratained_iof_adicional_cents", default: 0, null: false
    t.string "tax_ratained_iof_adicional_currency", default: "BRL", null: false
    t.datetime "approval_date"
    t.datetime "closure_date"
    t.string "status"
    t.bigint "seller_id"
    t.index ["seller_id"], name: "index_operations_on_seller_id"
  end

  create_table "payers", force: :cascade do |t|
    t.string "identification_number"
    t.string "company_name"
    t.string "company_nickname"
    t.string "business_entity"
    t.string "registration_number"
    t.string "nire"
    t.datetime "incorporation_date"
    t.string "zip_code"
    t.string "address"
    t.string "address_number"
    t.string "neighborhood"
    t.string "address_2"
    t.string "state"
    t.string "city"
    t.string "corporate_capital"
    t.string "activity"
    t.string "cnae"
    t.string "tax_option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "phone_number"
  end

  create_table "payers_concentrations", force: :cascade do |t|
    t.bigint "payer_id"
    t.bigint "operation_id"
    t.integer "concentration_cents", default: 0, null: false
    t.string "concentration_currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_payers_concentrations_on_operation_id"
    t.index ["payer_id"], name: "index_payers_concentrations_on_payer_id"
  end

  create_table "payers_limits", force: :cascade do |t|
    t.bigint "payer_id"
    t.integer "total_limit_cents", default: 0, null: false
    t.string "total_limit_currency", default: "BRL", null: false
    t.integer "used_limit_cents", default: 0, null: false
    t.string "used_limit_currency", default: "BRL", null: false
    t.bigint "operation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_payers_limits_on_operation_id"
    t.index ["payer_id"], name: "index_payers_limits_on_payer_id"
  end

  create_table "qualitative_informations", force: :cascade do |t|
    t.bigint "seller_id"
    t.boolean "address_verification"
    t.string "address_verification_observation"
    t.integer "law_suits_quantity"
    t.integer "law_suits_amount_cents", default: 0, null: false
    t.string "law_suits_amount_currency", default: "BRL", null: false
    t.string "website"
    t.string "google"
    t.string "linkedin"
    t.string "facebook"
    t.string "corporate_email"
    t.string "reclame_aqui"
    t.integer "reclame_aqui_complaints_quantity"
    t.integer "reclame_aqui_answered_complaints"
    t.string "google_maps"
    t.string "information_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_qualitative_informations_on_seller_id"
  end

  create_table "rebuys", force: :cascade do |t|
    t.bigint "operation_id"
    t.bigint "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_rebuys_on_invoice_id"
    t.index ["operation_id"], name: "index_rebuys_on_operation_id"
  end

  create_table "revenues", force: :cascade do |t|
    t.bigint "seller_id"
    t.integer "jan_cents", default: 0, null: false
    t.string "jan_currency", default: "BRL", null: false
    t.integer "feb_cents", default: 0, null: false
    t.string "feb_currency", default: "BRL", null: false
    t.integer "mar_cents", default: 0, null: false
    t.string "mar_currency", default: "BRL", null: false
    t.integer "apr_cents", default: 0, null: false
    t.string "apr_currency", default: "BRL", null: false
    t.integer "may_cents", default: 0, null: false
    t.string "may_currency", default: "BRL", null: false
    t.integer "jun_cents", default: 0, null: false
    t.string "jun_currency", default: "BRL", null: false
    t.integer "jul_cents", default: 0, null: false
    t.string "jul_currency", default: "BRL", null: false
    t.integer "aug_cents", default: 0, null: false
    t.string "aug_currency", default: "BRL", null: false
    t.integer "sep_cents", default: 0, null: false
    t.string "sep_currency", default: "BRL", null: false
    t.integer "oct_cents", default: 0, null: false
    t.string "oct_currency", default: "BRL", null: false
    t.integer "nov_cents", default: 0, null: false
    t.string "nov_currency", default: "BRL", null: false
    t.integer "dec_cents", default: 0, null: false
    t.string "dec_currency", default: "BRL", null: false
    t.string "information_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_revenues_on_seller_id"
  end

  create_table "season_sales", force: :cascade do |t|
    t.bigint "seller_id"
    t.boolean "jan"
    t.boolean "feb"
    t.boolean "mar"
    t.boolean "apr"
    t.boolean "may"
    t.boolean "jun"
    t.boolean "jul"
    t.boolean "aug"
    t.boolean "sep"
    t.boolean "oct"
    t.boolean "nov"
    t.boolean "dec"
    t.string "information_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_id"], name: "index_season_sales_on_seller_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "identification_number"
    t.string "company_name"
    t.string "company_nickname"
    t.string "business_entity"
    t.string "registration_number"
    t.string "nire"
    t.string "incorporation_date"
    t.string "zip_code"
    t.string "address"
    t.string "address_number"
    t.string "neighborhood"
    t.string "address_2"
    t.string "state"
    t.string "city"
    t.string "corporate_capital"
    t.string "activity"
    t.string "cnae"
    t.string "tax_option"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "phone_number"
    t.index ["client_id"], name: "index_sellers_on_client_id"
  end

  create_table "sellers_concentrations", force: :cascade do |t|
    t.bigint "seller_id"
    t.bigint "operation_id"
    t.integer "concentration_cents", default: 0, null: false
    t.string "concentration_currency", default: "BRL", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_sellers_concentrations_on_operation_id"
    t.index ["seller_id"], name: "index_sellers_concentrations_on_seller_id"
  end

  create_table "sellers_limits", force: :cascade do |t|
    t.bigint "seller_id"
    t.integer "total_limit_cents", default: 0, null: false
    t.string "total_limit_currency", default: "BRL", null: false
    t.integer "used_limit_cents", default: 0, null: false
    t.string "used_limit_currency", default: "BRL", null: false
    t.bigint "operation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_sellers_limits_on_operation_id"
    t.index ["seller_id"], name: "index_sellers_limits_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
    t.index ["client_id"], name: "index_users_on_client_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "debts", "debt_types"
  add_foreign_key "debts", "finantial_institutions"
  add_foreign_key "debts", "sellers"
  add_foreign_key "equity_holders", "payers"
  add_foreign_key "equity_holders", "sellers"
  add_foreign_key "finantials", "sellers"
  add_foreign_key "installments", "invoices"
  add_foreign_key "invoices", "operations"
  add_foreign_key "invoices", "payers"
  add_foreign_key "operations", "sellers"
  add_foreign_key "payers_concentrations", "operations"
  add_foreign_key "payers_concentrations", "payers"
  add_foreign_key "payers_limits", "operations"
  add_foreign_key "payers_limits", "payers"
  add_foreign_key "qualitative_informations", "sellers"
  add_foreign_key "rebuys", "invoices"
  add_foreign_key "rebuys", "operations"
  add_foreign_key "revenues", "sellers"
  add_foreign_key "season_sales", "sellers"
  add_foreign_key "sellers", "clients"
  add_foreign_key "sellers_concentrations", "operations"
  add_foreign_key "sellers_concentrations", "sellers"
  add_foreign_key "sellers_limits", "operations"
  add_foreign_key "sellers_limits", "sellers"
  add_foreign_key "users", "clients"
end
