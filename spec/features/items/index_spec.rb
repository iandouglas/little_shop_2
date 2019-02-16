require 'rails_helper'

RSpec.describe 'As any user' do
  context 'when it visits the index page' do

    it 'can see all enabled items' do
      Faker::UniqueGenerator.clear
      user = create(:user)
      user.update(role: 1)
      i1, i2, i3, i4, i5 = create_list(:item, 5, user: user)
      i4.update(activation_status: 1)
      i5.update(activation_status: 1)

      active_items = [i1, i2, i3]
      inactive_items = [i4, i5]

      visit items_path

      active_items.each do |item|
        expect(page).to have_content(item.title)
        expect(page).to have_css("img[src*='#{item.image_url}']")
        expect(page).to have_content("Sold By: #{item.user.name}")
        expect(page).to have_content("Qty: #{item.quantity}")
        expect(page).to have_content("Current Price: $#{item.price}")
      end

      inactive_items.each do |item|
        expect(page).to_not have_content(item.title)
      end
    end

    it 'items name is a link' do
      
      Faker::UniqueGenerator.clear

      user = create(:user)
      user.update(role: 1)
      i1, i2 = create_list(:item, 2, user: user)

      visit items_path

      click_link "#{i1.title}"

      expect(current_path).to eq(item_path(i1))
      expect(page).to have_content(i1.title)
      expect(page).to_not have_content(i2.title)
    end

    # it 'items image is a link' do
    #   user = create(:user)
    #   user.update(role: 1)
    #   i1, i2, i3, i4, i5 = create_list(:item, 5)
    #   i4.update(activation_status: "inactive")
    #   i5.update(activation_status: "inactive")
    #   i1.update(user: user)
    #   i2.update(user: user)
    #   i3.update(user: user)
    #   i4.update(user: user)
    #   i5.update(user: user)
    #
    #   visit items_path
    #
    #   # within ".id-#{i1.id}-row" do
    #   #   find("img[src*='#{i1.image_url}']").click
    #   # end
    #
    #   expect(current_path).to eq(item_path(i1))
    #   expect(page).to have_content(i1.title)
    #   expect(page).to_not have_content(i2.title)
    # end

  end
end
