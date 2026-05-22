export interface EffectSettings {
  previewVp: number;
  imageFilterSigma: number;
  glowSigma: number;
  tintMatrix: Array<number>;
  colors: EffectPalette;
}

export interface EffectPalette {
  screen: number;
  text: number;
  shadow: number;
  glow: number;
}

export const DEFAULT_EFFECT_SETTINGS: EffectSettings = {
  previewVp: 144,
  imageFilterSigma: 3.2,
  glowSigma: 12.0,
  tintMatrix: [
    1.05, 0.03, 0.00, 0.00, 0.0,
    0.00, 0.88, 0.06, 0.00, 0.0,
    0.06, 0.08, 1.10, 0.00, 0.0,
    0.00, 0.00, 0.00, 1.00, 0.0
  ],
  colors: {
    screen: 0xFF050914,
    text: 0xFFF7FBFF,
    shadow: 0xAA000000,
    glow: 0xEE52F6FF
  }
};
