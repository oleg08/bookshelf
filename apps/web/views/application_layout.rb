module Web
  module Views
    class ApplicationLayout
      include Web::Layout
      include Hanami::Helpers::HtmlHelper

      def navigation
        html.ul(class: 'navbar-nav mr-auto') do
          li(class: 'nav-item') do
            (link_to('Home', routes.root_path, class: 'nav-link'))
          end
          li(class: 'nav-item') do
            (link_to('Add Book', '/books/new', class: 'nav-link'))
          end
          li(class: 'nav-item') do
            (link_to('Books', routes.books_path, class: 'nav-link'))
          end
        end
      end
    end
  end
end
