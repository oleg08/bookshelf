require 'spec_helper'
require_relative '../../../../apps/web/controllers/books/create'

describe Web::Controllers::Books::Create do
  let(:action) { Web::Controllers::Books::Create.new }
  let(:params) { Hash[book: { title: 'Confident Ruby', author: 'Avdi Grimm' }] }

  before do
    BookRepository.new.clear
  end

  after do
    BookRepository.new.clear
  end

  describe 'with valid params' do
    it 'creates a new book' do
      action.call(params)

      expect(action.book.id).not_to be_nil
      expect(action.book.title).to eq params[:book][:title]
    end

    it 'redirects the user to the books listing' do
      response = action.call(params)

      expect(response[0]).to eq 302
      expect(response[1]['Location']).to eq '/books'
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[book: {}] }

    it 're-renders the books#new view' do
      response = action.call(params)
      expect(response[0]).to eq 422
    end

    it 'sets errors attribute accordingly' do
      response = action.call(params)
      expect(response[0]).to eq 422

      expect(action.params.errors[:book][:title]).to eq  ['is missing']
      expect(action.params.errors[:book][:author]).to eq ['is missing']
    end
  end

end
