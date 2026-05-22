import { DrawContext, RenderNode } from '@kit.ArkUI';
import { EffectStageId } from '../model/EffectStage';
import { DEFAULT_EFFECT_SETTINGS, EffectSettings } from '../model/EffectSettings';
import { EffectsPipeline } from './EffectsPipeline';

export class VisualEffectsRenderNode extends RenderNode {
  private stageId: EffectStageId = EffectStageId.BASE;
  private settings: EffectSettings = DEFAULT_EFFECT_SETTINGS;
  private pipeline: EffectsPipeline = new EffectsPipeline();

  setStage(stageId: EffectStageId, settings: EffectSettings): void {
    this.stageId = stageId;
    this.settings = settings;
    this.invalidate();
  }

  draw(context: DrawContext): void {
    const widthPx: number = context.sizeInPixel.width;
    const heightPx: number = context.sizeInPixel.height;
    this.pipeline.draw(context.canvas, widthPx, heightPx, this.stageId, this.settings);
  }
}
