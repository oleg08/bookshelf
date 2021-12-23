module Web::Views::Home
  class Index
    include Web::View
    include Hanami::Helpers::HtmlHelper

    def path_to_books
      html.div do
        link_to('Books', routes.books_path)
      end
    end
  end
end
