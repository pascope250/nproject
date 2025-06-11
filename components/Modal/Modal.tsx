// components/Modal/Modal.tsx
'use client';

import { ReactNode } from 'react';
import { XMarkIcon } from '@heroicons/react/24/outline';
import { twMerge } from 'tailwind-merge';

interface ModalProps {
  isOpen: boolean;
  onClose: () => void;
  title: string;
  children: ReactNode;
  footer?: ReactNode;
  size?: 'sm' | 'md' | 'lg' | 'xl';
  overlayClassName?: string;
  contentClassName?: string;
  overlayOpacity?: number; // New prop for overlay opacity
}

export function Modal({
  isOpen,
  onClose,
  title,
  children,
  footer,
  size = 'md',
  overlayClassName = '',
  contentClassName = '',
  overlayOpacity = 50, // Default to 50% opacity
}: ModalProps) {
  if (!isOpen) return null;

  const sizeClasses = {
    sm: 'max-w-sm',
    md: 'max-w-md',
    lg: 'max-w-lg',
    xl: 'max-w-xl',
  };

  // Convert overlayOpacity (0-100) to 0-1 for rgba
  const overlayOpacityValue = Math.max(0, Math.min(overlayOpacity, 100)) / 100;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
      {/* Overlay */}
      <div
        className={twMerge(
          'absolute inset-0 transition-opacity duration-300 ease-in-out',
          overlayClassName
        )}
        style={{
          background: `rgba(0,0,0,${overlayOpacityValue})`,
          backdropFilter: 'blur(4px)',
        }}
        onClick={onClose}
      />
      {/* Modal Content */}
      <div
        className={twMerge(
          `relative bg-white rounded-lg shadow-xl w-full ${sizeClasses[size]} max-h-[90vh] overflow-y-auto`,
          'transform transition-all duration-300 ease-in-out',
          contentClassName
        )}
        style={{ zIndex: 10 }}
      >
        <div className="flex justify-between items-center sticky top-0 bg-white p-4 border-b z-10">
          <h2 className="text-xl font-semibold text-gray-800">{title}</h2>
          <button
            onClick={onClose}
            className="text-gray-500 hover:text-gray-700 transition-colors"
            aria-label="Close modal"
          >
            <XMarkIcon className="h-6 w-6" />
          </button>
        </div>

        <div className="p-4">{children}</div>

        {footer && (
          <div className="sticky bottom-0 bg-white p-4 border-t flex justify-end space-x-3">
            {footer}
          </div>
        )}
      </div>
    </div>
  );
}