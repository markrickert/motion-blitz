module Motion
  # blitz (fl•ash), verb
  # 1. Shine in a bright but brief, sudden, or intermittent way
  # 2. Control the display of temporary messages via SVProgressHUD

  class Blitz
    STYLES = {
      light:  SVProgressHUDStyleLight,
      dark:   SVProgressHUDStyleDark,
      custom: SVProgressHUDStyleCustom
    }

    MASKS = {
      none:     SVProgressHUDMaskTypeNone,
      clear:    SVProgressHUDMaskTypeClear,
      black:    SVProgressHUDMaskTypeBlack,
      gradient: SVProgressHUDMaskTypeGradient,
      custom:   SVProgressHUDMaskTypeCustom
    }

    ANIMATION_TYPES = {
      flat:   SVProgressHUDAnimationTypeFlat,
      native: SVProgressHUDAnimationTypeNative
    }

    class << self

      def style=(style)
        check_style(style)
        hud_class.setDefaultStyle(STYLES[style])
      end

      def mask=(mask)
        check_mask(mask)
        hud_class.setDefaultMaskType(MASKS[mask])
      end

      def animation_type=(type)
        check_animation_type(type)
        hud_class.setDefaultAnimationType(ANIMATION_TYPES[type])
      end

      def minimum_size=(size)
        hud_class.setMinimumSize(size)
      end

      def ring_thickness=(thickness)
        hud_class.setRingThickness(thickness)
      end

      def ring_radius=(radius)
        hud_class.setRingRadius(radius)
      end

      def ring_no_text_radius=(radius)
        hud_class.setRingNoTextRadius(radius)
      end

      def corner_radius=(radius)
        hud_class.setCornerRadius(radius)
      end

      def font=(font)
        hud_class.setFont(font)
      end

      def foreground_color=(color)
        hud_class.setForegroundColor(color)
      end

      def background_color=(color)
        hud_class.setBackgroundColor(color)
      end

      def background_layer_color=(color)
        hud_class.setBackgroundLayerColor(color)
      end

      def info_image=(image)
        hud_class.setInfoImage(image)
      end

      def success_image=(image)
        hud_class.setSuccessImage(image)
      end

      def error_image=(image)
        hud_class.setErrorImage(image)
      end

      def minimum_dismiss_time_interval=(interval)
        hud_class.setMinimumDismissTimeInterval(interval)
      end

      def fade_in_duration=(duration)
        hud_class.setFadeInAnimationDuration(duration)
      end

      def fade_out_duration=(duration)
        hud_class.setFadeOutAnimationDuration(duration)
      end

      def show(message_or_mask = nil, mask = :none)
        if message_or_mask.is_a? Symbol
          show(nil, message_or_mask)
        else
          mask = MASKS[mask] unless mask == MASKS[mask]
          hud_class.showWithStatus(message_or_mask)
        end
      end

      def text=(new_text)
        if visible?
          hud_class.setStatus(new_text)
        else
          raise ArgumentError, "You can not change the text of the hud unless it is showing."
        end
      end

      def progress(progress, message_or_mask = nil, mask = :none)
        if message_or_mask.is_a? Symbol
          progress(progress, nil, message_or_mask)
        else
          mask = MASKS[mask] unless mask == MASKS[mask]
          hud_class.showProgress(progress, status: message_or_mask)
        end
      end

      def loading(mask = :none)
        show('Loading...', mask)
      end

      def info(message = nil)
        hud_class.showInfoWithStatus(message)
      end

      def success(message = nil)
        hud_class.showSuccessWithStatus(message)
      end

      def error(message = nil)
        hud_class.showErrorWithStatus(message)
      end

      def image(image, message = nil)
        hud_class.showImage(image, status: message)
      end

      def pop
        hud_class.popActivity
      end

      def dismiss(delay = nil, &block)
        if delay.nil?
          if block_given?
            hud_class.dismissWithCompletion(block)
          else
            hud_class.dismiss
          end
        else
          if block_given?
            hud_class.dismissWithDelay(delay, completion: block)
          else
            hud_class.dismissWithDelay(delay)
          end
        end
      end

      def visible?
        hud_class.isVisible
      end

      private

      def hud_class
        SVProgressHUD
      end

      def check_style(style)
        raise ArgumentError, "style must be one of #{STYLES.keys}" unless STYLES.keys.include?(style)
      end

      def check_mask(mask)
        raise ArgumentError, "mask must be one of #{MASKS.keys}" unless MASKS.keys.include?(mask)
      end

      def check_animation_type(type)
        raise ArgumentError, "type must be one of #{ANIMATION_TYPES.keys}" unless ANIMATION_TYPES.keys.include?(type)
      end
    end
  end
end
