require 'spec_helper'
require_relative '../../../../apps/web/views/books/index'

RSpec.describe Web::Views::Books::Index, type: :view do
  let(:exposures) { Hash[books: []] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/books/index.html.erb') }
  let(:view)      { Web::Views::Books::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #books' do
    expect(view.books).to eq exposures.fetch(:books)
  end

  describe 'when there are no books' do
    it 'shows a placeholder message' do
      expect(rendered).to include('<p class="placeholder">There are no books yet.</p>')
    end
  end

  describe 'when there are books' do
    let(:book1)     { Book.new(title: 'Refactoring', author: 'Martin Fowler') }
    let(:book2)     { Book.new(title: 'Domain Driven Design', author: 'Eric Evans') }
    let(:exposures) { Hash[books: [book1, book2]] }

    it 'lists them all' do
      rendered.scan(/class="book"/).count eq 2
      expect(rendered).to include('Refactoring')
      expect(rendered).to include('Domain Driven Design')
    end

    it 'hides the placeholder message' do
      expect(rendered).not_to include('<p class="placeholder">There are no books yet.</p>')
    end
  end
end
