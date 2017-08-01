# Encoding: UTF-8
require 'spec_helper'

def download_first_file_at(path)
  visit path
  find('.download_icon').click
  expect(page).to have_content('http://www.refineryhq.com/')
end

module Refinery
  module Admin

    describe 'Resources', :type => :feature do
      refinery_login

      context 'when there are no files' do
        it 'says there are no files' do
          visit refinery.admin_resources_path
          expect(page).to have_content(%q{There are no files yet.})
        end
      end

      it 'shows upload file link' do
        visit refinery.admin_resources_path
        expect(page).to have_link('Upload new file', href:'/refinery/resources/new?dialog=true')
      end

      describe 'new/create' do
        it "uploads a file", :js => true do
          visit refinery.admin_resources_path
          find('a', text: 'Upload new file').trigger(:click)

          expect(page).to have_selector 'iframe#dialog_iframe'

          page.within_frame('dialog_iframe') do
            attach_file "resource_file", Refinery.roots('refinery/resources').
                                                  join("spec/fixtures/refinery_is_awesome.txt")
            click_button ::I18n.t('save', :scope => 'refinery.admin.form_actions')
          end
          expect(page).to have_content("Refinery Is Awesome")
          expect(Refinery::Resource.count).to eq(1)
        end

        describe "max file size" do
          before do
            allow(Refinery::Resources).to receive(:max_file_size).and_return('1224')
          end

          context "in english" do
            before do
              allow(Refinery::I18n).to receive(:current_locale).and_return(:en)
            end

            it "is shown" do
              visit refinery.admin_resources_path
              click_link "Upload new file"

              within('#file') do
                expect(page).to have_selector("a[tooltip='The maximum file size is 1.2 KB.']")
              end
            end
          end

          context "in danish" do
            before do
              allow(Refinery::I18n).to receive(:current_locale).and_return(:da)
            end

            it "is shown" do
              visit refinery.admin_resources_path

              click_link "Tilføj en ny fil"
              within "#file" do
                expect(page).to have_selector("a[tooltip='Filen må maksimalt fylde 1,2 KB.']")
              end
            end
          end
        end
      end

      context "edit/update" do
        let!(:resource) { FactoryGirl.create(:resource) }

        it 'can be edited by clicking on the title field' do
          visit refinery.admin_resources_path
          expect(page).to have_selector("li.record > a[href='/refinery/resources/#{resource.id}/edit']")
        end

        it 'can be edited by clicking on the edit icon' do
          visit refinery.admin_resources_path
          within 'span.actions' do
            expect(page).to have_selector("a[href='/refinery/resources/#{resource.id}/edit']")
          end
        end

        it "updates file" do
          visit refinery.admin_resources_path
          find("span.actions a[href='/refinery/resources/#{resource.id}/edit']").click

          expect(page).to have_content("Refinery Is Awesome or replace it with this one...")
          expect(page).to have_selector("a[href*='/refinery/resources']")

          attach_file "resource_file", Refinery.roots('refinery/resources').join("spec/fixtures/refinery_is_awesome2.txt")
          click_button "Save"

          expect(page).to have_content("Refinery Is Awesome2")
          expect(Refinery::Resource.count).to eq(1)
        end

        describe "translate" do
          before do
            allow(Refinery::I18n).to receive(:frontend_locales).and_return([:en, :fr])
          end

          it "can have a second locale added to it" do
            visit refinery.admin_resources_path
            expect(page).to have_content("Refinery Is Awesome")

            find("a[href='/refinery/resources/#{resource.id}/edit']", match: :first).click

            within "#switch_locale_picker" do
              click_link "FR"
            end

            fill_in "Title", :with => "Premier fichier"
            click_button "Save"

            expect(page).to have_content("'Premier fichier' was successfully updated.")
            expect(Resource.translation_class.count).to eq(1)
          end
        end
      end

      describe "destroy" do
        let!(:resource) { FactoryGirl.create(:resource) }

        it "removes the resource" do
          visit refinery.admin_resources_path

          expect(page).to have_selector("a[href='/refinery/resources/#{resource.id}']")
          click_link "Remove this file forever"

          expect(page).to have_content("'Refinery Is Awesome' was successfully removed.")
          expect(Refinery::Resource.count).to eq(0)
        end
      end

      describe 'downloading' do
        let!(:resource) { FactoryGirl.create(:resource) }

        it 'downloads the selected file' do
          download_first_file_at refinery.admin_resources_path
        end

        context 'when the extension is mounted with a named space' do
          before do
            Rails.application.routes.draw do
              mount Refinery::Core::Engine, :at => '/about'
            end
            Rails.application.routes_reloader.reload!
          end

          after do
            Rails.application.routes.draw do
              mount Refinery::Core::Engine, :at => '/'
            end
          end

          it 'downloads the selected file' do
            download_first_file_at refinery.admin_resources_path
          end
        end
      end
    end
  end
end
