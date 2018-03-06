namespace :import do
  desc "Given the path of a excel spreadsheet exported from Smart it will import paid invoices "
  task :paid_invoices, [:path] do |t, args|
    path = args.path
    LegacyImportation.new.paid_invoices_importation(path)
  end

  desc "Given the path of a excel spreadsheet exported from Smart it will import opened invoices "
  task :opened_invoices, [:path] do |t, args|
    path = args.path
    LegacyImportation.new.opened_invoices_importation(path)
  end
end
