import { EffectExplanation } from '../components/EffectExplanation';
import { EffectsPreview } from '../components/EffectsPreview';
import { StageChip } from '../components/StageChip';
import { DEFAULT_EFFECT_SETTINGS } from '../model/EffectSettings';
import { EFFECT_STAGES, EffectStageId, EffectStageInfo, findEffectStage } from '../model/EffectStage';

@Entry
@Component
struct Index {
  @State selectedStage: EffectStageId = EffectStageId.BASE;

  private selectStage(stageId: EffectStageId): void {
    this.selectedStage = stageId;
  }

  build() {
    Stack() {
      Scroll() {
        Column({ space: 4 }) {
          Text('Visual Effects')
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor('#F7FBFF')
            .textAlign(TextAlign.Center)
            .width('100%')
          Text('ArkGraphics2D Pipeline')
            .fontSize(8)
            .fontColor('#9FB2CC')
            .textAlign(TextAlign.Center)
            .width('100%')

          EffectsPreview({ stageId: this.selectedStage, settings: DEFAULT_EFFECT_SETTINGS })

          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
            ForEach(EFFECT_STAGES, (stage: EffectStageInfo) => {
              StageChip({
                label: stage.label,
                stageId: stage.id,
                selected: this.selectedStage === stage.id,
                onSelect: (stageId: EffectStageId) => {
                  this.selectStage(stageId);
                }
              })
            }, (stage: EffectStageInfo) => stage.id)
          }
          .width('100%')

          EffectExplanation({ stage: findEffectStage(this.selectedStage) })
        }
        .width(188)
        .padding({ top: 7, bottom: 36 })
        .alignItems(HorizontalAlign.Center)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .backgroundColor('#050914')
    .height('100%')
    .width('100%')
  }
}
