export enum EffectStageId {
  BASE = 'base',
  TINT = 'tint',
  BLUR = 'blur',
  GLOW = 'glow',
  SHADOW = 'shadow',
  FINAL = 'final'
}

export interface EffectStageInfo {
  id: EffectStageId;
  label: string;
  moduleName: string;
  summary: string;
}

export const EFFECT_STAGES: EffectStageInfo[] = [
  {
    id: EffectStageId.BASE,
    label: 'Base',
    moduleName: 'ShaderEffect',
    summary: 'Source tile: gradient sky, sun, mountains, ground, and a small 21C reading. ShaderEffect paints the tile surface; no filter is added yet.'
  },
  {
    id: EffectStageId.TINT,
    label: 'Tint',
    moduleName: 'ColorFilter',
    summary: 'ColorFilter applies a cool matrix to the artwork. The sky, sun, and ground shift together without turning the tile white.'
  },
  {
    id: EffectStageId.BLUR,
    label: 'Blur',
    moduleName: 'ImageFilter',
    summary: 'ImageFilter blurs the grouped artwork layer inside the tile without shifting it. The sun, mountains, and ground are filtered together, not one by one.'
  },
  {
    id: EffectStageId.GLOW,
    label: 'Glow',
    moduleName: 'MaskFilter',
    summary: 'MaskFilter draws a transparent-inside cyan blur after the tile. Only the outside halo is visible, so it reads as light rather than a frame.'
  },
  {
    id: EffectStageId.SHADOW,
    label: 'Shadow',
    moduleName: 'ShadowLayer',
    summary: 'ShadowLayer applies only to text. This stage adds a soft shadow to the existing 21C reading, so the API is visible without adding a random label.'
  },
  {
    id: EffectStageId.FINAL,
    label: 'Final',
    moduleName: 'All modules',
    summary: 'Final combines the effects already shown: shader-filled tile, cool color grade, filtered artwork, cyan halo, and the 21C text shadow.'
  }
];

export function findEffectStage(id: EffectStageId): EffectStageInfo {
  for (let index = 0; index < EFFECT_STAGES.length; index++) {
    if (EFFECT_STAGES[index].id === id) {
      return EFFECT_STAGES[index];
    }
  }
  return EFFECT_STAGES[0];
}
