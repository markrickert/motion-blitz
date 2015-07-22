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

      end

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
