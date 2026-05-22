import { EffectStageInfo } from '../model/EffectStage';

@Component
export struct EffectExplanation {
  @Prop stage: EffectStageInfo;

  build() {
    Column() {
      Text(this.stage.moduleName)
        .fontSize(9)
        .fontWeight(FontWeight.Bold)
        .fontColor('#6EE7F9')
        .width('100%')
      Scroll() {
        Text(this.stage.summary)
          .fontSize(8)
          .lineHeight(11)
          .fontColor('#D8E6F8')
          .width('100%')
      }
      .scrollBar(BarState.Off)
      .height(42)
      .width('100%')
    }
    .padding({ left: 10, right: 10, top: 6, bottom: 6 })
    .backgroundColor('#121C2E')
    .borderRadius(14)
    .border({ width: 1, color: '#263B5D' })
    .width('100%')
  }
}
