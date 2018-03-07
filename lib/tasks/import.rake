require File.expand_path(File.dirname(__FILE__) + '../../../config/environment.rb')

namespace :import do
  desc "Given the path of a excel spreadsheet exported from Smart it will import paid invoices "
  task :paid_invoices, [:path] => :environment do |t, args|
    path = args.path
    LegacyImportation.new.paid_invoices_importation(path)
  end

  desc "Given the path of a excel spreadsheet exported from Smart it will import opened invoices "
  task :opened_invoices, [:path] => :environment do |t, args|
    path = args.path
    LegacyImportation.new.opened_invoices_importation(path)
  end

  desc "Given the path of a excel spreadsheet exported from Smart it will import payers "
  task :payers, [:path] => :environment do |t, args|
    path = args.path
    LegacyImportation.new.payers_importation(path)
  end
end
