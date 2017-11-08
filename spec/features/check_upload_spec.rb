require 'spec_helper'

describe "check for successful data upload" do

  before :all do
    @owner = User.find_by(login: OWNER)
  end

  it "checks that the file has been uploaded" do
    login_as(@owner, :scope => :user)
    sleep(60)
    puts @owner.login
    collection = Collection.second
    puts collection.title
    collection.works.each do |w|
      puts w.title
    end

    DocumentUpload.all.each do |upload|
      puts upload.file
      puts upload.status
    end

=begin
    @work = Work.find_by(title: 'test')
    visit collection_read_work_path(@work.collection.owner, @work.collection, @work)
    expect(page).to have_content(@work.title)
    expect(page).to have_content(@work.pages.first.title)
=end
  end

end