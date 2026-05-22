import { EffectStageId } from '../model/EffectStage';

@Component
export struct StageChip {
  @Prop label: string;
  @Prop stageId: EffectStageId;
  @Prop selected: boolean;
  onSelect: (stageId: EffectStageId) => void = () => {};

  build() {
    Text(this.label)
      .fontSize(9)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selected ? '#061018' : '#D7E7FF')
      .textAlign(TextAlign.Center)
      .padding({ left: 7, right: 7, top: 4, bottom: 4 })
      .margin({ right: 4, bottom: 4 })
      .backgroundColor(this.selected ? '#6EE7F9' : '#1A2740')
      .borderRadius(10)
      .border({ width: 1, color: this.selected ? '#BFF7FF' : '#355071' })
      .onClick(() => {
        this.onSelect(this.stageId);
      })
  }
}
