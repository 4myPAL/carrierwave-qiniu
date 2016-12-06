module CarrierWave
  module Qiniu
    module Url
      # === Examples:
      #
      #     avatar.url(:version)
      #     avatar.url(:version, inline: true)
      #     avatar.url(style: 'imageView2/0/w/200')
      #
      def url(*args)
        return super if args.empty?

        # Usage: avatar.url(style: 'imageView/0/w/200')
        if args.first.is_a? Hash
          options = args.first
          if options[:style]
            url = super({})
            return "#{url}?#{options[:style]}"
          end
        else
        # Usage: avatar.url(version, options)
          version = args.first.to_sym
          if styles.key? version.to_sym
            options = args.last
            return super(style: version, separator: self.class.qiniu_style_separator)
          end
        end

        # Fallback to original url
        super
      end

      def styles
        self.class.get_qiniu_styles
      end
    end
  end
end
