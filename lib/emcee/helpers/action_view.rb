module Emcee
  module Helpers
    module ActionView
      module AssetUrlHelper
        # Convenience method for html based on javascript_path.
        def html_path(source, options = {})
          path_to_asset(source, { type: :html }.merge!(options))
        end
        alias_method :path_to_html, :html_path
      end

      module AssetTagHelper
        def path_to_html(source, options = {})
          path_to_asset(source, { type: :html }.merge!(options))
        end

        # Custom view helper used to create an html import. Will search the asset
        # directories for the sources.
        #
        #   html_import_tag("navigation")
        #
        def html_import_tag(*sources)
          options = sources.extract_options!.stringify_keys
          path_options = options.extract!('protocol').symbolize_keys

          sources.uniq.map { |source|
            tag_options = {
              "rel" => "import",
              "href" => path_to_html(source, path_options)
            }.merge!(options)
            tag(:link, tag_options)
          }.join("\n").html_safe
        end
      end
    end
  end
end
