/**
 * 通用表单提交工具类
 * 统一处理所有表单的提交逻辑
 */

export interface FormSubmitOptions {
  formId: string;
  successId: string;
  type: string;
  apiUrl?: string;
  onSuccess?: () => void;
  onError?: (error: string) => void;
}

export class FormSubmitHandler {
  private options: FormSubmitOptions;

  constructor(options: FormSubmitOptions) {
    this.options = {
      apiUrl: '/api/send-email.json',
      ...options
    };
    this.init();
  }

  private init(): void {
    const form = document.getElementById(this.options.formId) as HTMLFormElement;
    if (!form) {
      console.error(`Form with ID "${this.options.formId}" not found`);
      return;
    }

    form.addEventListener('submit', this.handleSubmit.bind(this));
  }

  private async handleSubmit(event: Event): Promise<void> {
    event.preventDefault();

    const form = event.target as HTMLFormElement;
    const button = form.querySelector('button[type="submit"]') as HTMLButtonElement | null;
    
    if (!button) {
      console.error('Submit button not found in form');
      return;
    }
    
    const originalText = button.textContent;

    button.textContent = 'Submitting...';
    button.disabled = true;

    try {
      const formData = new FormData(form);
      const data = Object.fromEntries(formData);

      // 添加表单类型
      data.type = this.options.type;

      const response = await fetch(this.options.apiUrl!, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
      });

      if (response.ok) {
        const result = await response.json();

        if (result.success) {
          // 显示成功消息
          const successElement = document.getElementById(this.options.successId);
          if (successElement) {
            successElement.classList.remove('hidden');
            successElement.scrollIntoView({ behavior: 'smooth' });
          }

          // 重置表单
          form.reset();

          // 调用成功回调
          if (this.options.onSuccess) {
            this.options.onSuccess();
          }
        } else {
          const errorMsg = result.error || 'Failed to submit form. Please try again later.';
          if (this.options.onError) {
            this.options.onError(errorMsg);
          } else {
            alert(errorMsg);
          }
        }
      } else {
        const errorMsg = 'API endpoint not found. Please check server configuration.';
        if (this.options.onError) {
          this.options.onError(errorMsg);
        } else {
          alert(errorMsg);
        }
      }
    } catch (error) {
      console.error('Error:', error);
      const errorMsg = 'Failed to submit form. Please try again later.';
      if (this.options.onError) {
        this.options.onError(errorMsg);
      } else {
        alert(errorMsg);
      }
    } finally {
      // 恢复按钮状态
      button.textContent = originalText;
      button.disabled = false;
    }
  }
}

/**
 * 初始化表单提交处理器
 * @param options 表单配置选项
 */
export function initFormSubmit(options: FormSubmitOptions): FormSubmitHandler {
  return new FormSubmitHandler(options);
}