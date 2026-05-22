import { FrameNode, NodeController, UIContext } from '@kit.ArkUI';
import { EffectStageId } from '../model/EffectStage';
import { DEFAULT_EFFECT_SETTINGS, EffectSettings } from '../model/EffectSettings';
import { VisualEffectsRenderNode } from './VisualEffectsRenderNode';

export class VisualEffectsNodeController extends NodeController {
  private rootNode: FrameNode | null = null;
  private renderNode: VisualEffectsRenderNode | null = null;
  private stageId: EffectStageId = EffectStageId.BASE;
  private settings: EffectSettings = DEFAULT_EFFECT_SETTINGS;

  makeNode(uiContext: UIContext): FrameNode | null {
    this.rootNode = new FrameNode(uiContext);
    const rootRenderNode = this.rootNode.getRenderNode();
    if (rootRenderNode !== null) {
      this.renderNode = new VisualEffectsRenderNode();
      this.renderNode.size = { width: this.settings.previewVp, height: this.settings.previewVp };
      this.renderNode.setStage(this.stageId, this.settings);
      rootRenderNode.appendChild(this.renderNode);
    }
    return this.rootNode;
  }

  update(stageId: EffectStageId, settings: EffectSettings): void {
    this.stageId = stageId;
    this.settings = settings;
    if (this.renderNode !== null) {
      this.renderNode.setStage(stageId, settings);
    }
  }
}
