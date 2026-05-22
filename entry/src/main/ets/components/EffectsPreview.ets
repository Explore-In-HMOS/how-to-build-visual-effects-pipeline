import { EffectStageId } from '../model/EffectStage';
import { EffectSettings } from '../model/EffectSettings';
import { VisualEffectsNodeController } from '../render/VisualEffectsNodeController';

@Component
export struct EffectsPreview {
  @Prop @Watch('refreshPreview') stageId: EffectStageId;
  @Prop @Watch('refreshPreview') settings: EffectSettings;
  private controller: VisualEffectsNodeController = new VisualEffectsNodeController();

  aboutToAppear(): void {
    this.controller.update(this.stageId, this.settings);
  }

  refreshPreview(): void {
    this.controller.update(this.stageId, this.settings);
  }

  build() {
    NodeContainer(this.controller)
      .width(this.settings.previewVp)
      .height(this.settings.previewVp)
      .onAreaChange(() => {
        this.controller.update(this.stageId, this.settings);
      })
  }
}
