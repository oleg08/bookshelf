module Web::Controllers::Books
  class New
    include Web::Action

    expose :book

    def call(params)
      @book = BookRepository.new
    end
  end
end