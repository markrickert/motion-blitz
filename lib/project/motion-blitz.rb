module Motion
  # blitz (fl•ash), verb
  # 1. Shine in a bright but brief, sudden, or intermittent way
  # 2. Control the display of temporary messages via SVProgressHUD

  class Blitz
    MASKS = {
      none:     SVProgressHUDMaskTypeNone,
      clear:    SVProgressHUDMaskTypeClear,
      black:    SVProgressHUDMaskTypeBlack,
      gradient: SVProgressHUDMaskTypeGradient
    }

    class << self
      def show(message_or_mask = nil, mask = :none)
        invoke({
          style: :show,
          status: message_or_mask.is_a?(Symbol) ? nil : message_or_mask,
          mask: message_or_mask.is_a?(Symbol) ? message_or_mask : mask
        })
      end

      def info(message_or_mask = nil, mask = :none)
        invoke({
          style: :info,
          status: message_or_mask.is_a?(Symbol) ? nil : message_or_mask,
          mask: message_or_mask.is_a?(Symbol) ? message_or_mask : mask
        })
      end

      def image(image, message_or_mask = nil, mask = :none)
        invoke({
          style: :image,
          image: image,
          status: message_or_mask.is_a?(Symbol) ? nil : message_or_mask,
          mask: message_or_mask.is_a?(Symbol) ? message_or_mask : mask
        })
      end

      def progress(progress, message_or_mask = nil, mask = :none)
        invoke({
          style: :progress,
          progress: progress,
          status: message_or_mask.is_a?(Symbol) ? nil : message_or_mask,
          mask: message_or_mask.is_a?(Symbol) ? message_or_mask : mask
        })
      end

      def loading(mask = :none)
        show('Loading...', mask)
      end

      def dismiss
        hud_class.dismiss
      end

      def success(message = nil, mask = :none)
        invoke({
          style: :success,
          status: message,
          mask: mask
        })
      end

      def error(message = nil, mask = :none)
        invoke({
          style: :error,
          status: message,
          mask: mask
        })
      end

      def invoke(options = {})
        options = {
          style: :show,
          mask: :none,
          status: nil,
          progress: nil,
          image: nil,
        }.merge(options)

        check_mask(options[:mask])
        mask = MASKS[options[:mask]]

        mp 'invoking with options:'
        mp options

        case options[:style]
        when :show
          if visible?
            hud_class.showWithStatus(options[:status])
          else
            hud_class.showWithStatus(options[:status], maskType: mask)
          end
        when :progress
          if visible?
            hud_class.showProgress(options[:progress], status: options[:status])
          else
            hud_class.showProgress(options[:progress], status: options[:status], maskType: mask)
          end
        when :info
          if visible?
            hud_class.showInfoWithStatus(options[:status])
          else
            hud_class.showInfoWithStatus(options[:status], maskType: mask)
          end
        when :success
          if visible?
            hud_class.showSuccessWithStatus(options[:status])
          else
            hud_class.showSuccessWithStatus(options[:status], maskType: mask)
          end
        when :error
          if visible?
            hud_class.showErrorWithStatus(options[:status])
          else
            hud_class.showErrorWithStatus(options[:status], maskType: mask)
          end
        when :image
          options[:image] = UIImage.imageNamed(options[:image]) if options[:image].is_a?(String)
          raise ArgumentError, "image must be a UIImage or string" unless options[:image].is_a?(UIImage)
          if visible?
            hud_class.showImage(options[:image], status: options[:status])
          else
            hud_class.showImage(options[:image], status: options[:status], maskType: mask)
          end
        end
      end

      def visible?
        hud_class.isVisible
      end

      # Style setters and getters

      # default is [UIColor whiteColor]
      def background_color=(color)
        hud_class.setBackgroundColor(color)
      end
      def background_color
        hud_class.sharedView.hudView.backgroundColor
      end

      # default is [UIColor blackColor]
      def foreground_color=(color)
        hud_class.setForegroundColor(color)
      end
      def foreground_color
        hud_class.sharedView.stringLabel.textColor
      end

      # default is 14 pt
      # this is in master but not in v1.1.3
      # def corner_radius=(radius)
      #   hud_class.setCornerRadius(radius)
      # end
      def corner_radius
        hud_class.sharedView.hudView.layer.cornerRadius
      end

      # default is 5 pt
      # def ring_thickness=(thickness)
      #   hud_class.setRingThickness(thickness)
      # end
      def ring_thickness
        hud_class.sharedView.indefiniteAnimatedView.strokeThickness
      end

      # default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
      def font=(font)
        hud_class.setFont(font)
      end
      def font
        hud_class.sharedView.stringLabel.font
      end

      # default is the bundled info image provided by Freepik
      def info_image=(image)
        image = UIImage.imageNamed(image) if image.is_a?(String)
        hud_class.setInfoImage(image)
      end
      # def info_image
      #   hud_class.infoImage
      # end

      # default is the bundled info image provided by Freepik
      def success_image=(image)
        image = UIImage.imageNamed(image) if image.is_a?(String)
        hud_class.setSuccessImage(image)
      end
      # def success_image
      #   hud_class.successImage
      # end

      # default is the bundled info image provided by Freepik
      def error_image=(image)
        image = UIImage.imageNamed(image) if image.is_a?(String)
        hud_class.setErrorImage(image)
      end
      # def error_image
      #   hud_class.errorImage
      # end

      # default is SVProgressHUDMaskTypeNone
      def default_mask_type=(mask)
        mask = MASKS[mask] if mask.is_a?(Symbol)
        hud_class.setDefaultMaskType(mask)
      end
      # def default_mask_type
      #   hud_class.defaultMaskType
      # end

      #default is nil, only used if #define SV_APP_EXTENSIONS is set
      def view=(view)
        hud_class.setViewForExtension(view)
      end
      # def view
      #   hud_class.viewForExtension
      # end


      private

      def hud_class
        SVProgressHUD
      end

      def check_mask(mask)
        raise ArgumentError, "mask must be one of #{MASKS.keys}" unless MASKS.keys.include?(mask)
      end
    end
  end
end
