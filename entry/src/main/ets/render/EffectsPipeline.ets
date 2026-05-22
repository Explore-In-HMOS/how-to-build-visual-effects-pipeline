import { common2D, drawing } from '@kit.ArkGraphics2D';
import { EffectStageId } from '../model/EffectStage';
import { EffectSettings } from '../model/EffectSettings';

export class EffectsPipeline {
  draw(canvas: drawing.Canvas, widthPx: number, heightPx: number, stageId: EffectStageId,
    settings: EffectSettings): void {
    const side: number = Math.min(widthPx, heightPx);
    const cx: number = widthPx / 2.0;
    const cy: number = heightPx / 2.0;
    const cardCx: number = cx;
    const cardCy: number = cy + side * 0.01;
    const cardSize: number = side * 0.88;
    this.clearToScreen(canvas, widthPx, heightPx, settings);

    if (stageId === EffectStageId.BASE) {
      this.drawPhotoCard(canvas, cardCx, cardCy, cardSize, false, false, false, settings);
    } else if (stageId === EffectStageId.FINAL) {
      this.drawPhotoCard(canvas, cardCx, cardCy, cardSize, true, true, true, settings);
      this.drawGlow(canvas, cardCx, cardCy, cardSize, settings);
    } else {
      this.drawPhotoCard(canvas, cardCx, cardCy, cardSize, stageId === EffectStageId.TINT,
        stageId === EffectStageId.SHADOW, stageId === EffectStageId.BLUR, settings);
      if (stageId === EffectStageId.GLOW) {
        this.drawGlow(canvas, cardCx, cardCy, cardSize, settings);
      }
    }
  }

  private clearToScreen(canvas: drawing.Canvas, widthPx: number, heightPx: number, settings: EffectSettings): void {
    const brush = new drawing.Brush();
    brush.setColor(settings.colors.screen);
    canvas.attachBrush(brush);
    canvas.drawRect(0.0, 0.0, widthPx, heightPx);
    canvas.detachBrush();
  }

  private drawPhotoCard(canvas: drawing.Canvas, cx: number, cy: number, size: number, tinted: boolean,
    textShadow: boolean, filtered: boolean, settings: EffectSettings): void {
    const tint = tinted ? drawing.ColorFilter.createMatrixColorFilter(settings.tintMatrix) : null;
    const panelRect = this.makeRoundRect(cx - size * 0.48, cy - size * 0.40, cx + size * 0.48,
      cy + size * 0.40, size * 0.09);
    const cardBrush = new drawing.Brush();
    cardBrush.setAntiAlias(true);
    const cardShader = drawing.ShaderEffect.createLinearGradient({ x: cx - size * 0.42, y: cy - size * 0.40 },
      { x: cx + size * 0.38, y: cy + size * 0.40 }, [0xFF72B6E7, 0xFF245D83], drawing.TileMode.CLAMP,
      [0.0, 1.0], null);
    cardBrush.setShaderEffect(cardShader);
    canvas.attachBrush(cardBrush);
    canvas.drawRoundRect(panelRect);
    canvas.detachBrush();

    if (tint !== null) {
      const tintWash = new drawing.Brush();
      tintWash.setAntiAlias(true);
      tintWash.setColor({
        alpha: 54,
        red: 70,
        green: 132,
        blue: 210
      });
      tintWash.setColorFilter(tint);
      canvas.attachBrush(tintWash);
      canvas.drawRoundRect(panelRect);
      canvas.detachBrush();
    }

    if (filtered) {
      this.drawFilteredArtworkLayer(canvas, cx, cy, size, tint, settings);
    } else {
      this.drawArtwork(canvas, cx, cy, size, tint);
    }
    this.drawReading(canvas, cx - size * 0.40, cy - size * 0.22, size * 0.12, textShadow, settings);

  }

  private drawFilteredArtworkLayer(canvas: drawing.Canvas, cx: number, cy: number, size: number,
    tint: drawing.ColorFilter | null, settings: EffectSettings): void {
    const filterBrush = new drawing.Brush();
    filterBrush.setImageFilter(this.createArtworkFilter(settings));
    const layerPad: number = size * 0.10;
    const layerRect: common2D.Rect = {
      left: cx - size * 0.48 - layerPad,
      top: cy - size * 0.35 - layerPad,
      right: cx + size * 0.48 + layerPad,
      bottom: cy + size * 0.40 + layerPad
    };
    canvas.saveLayer(layerRect, filterBrush);
    this.drawArtwork(canvas, cx, cy, size, tint);
    canvas.restore();
  }

  private drawArtwork(canvas: drawing.Canvas, cx: number, cy: number, size: number,
    tint: drawing.ColorFilter | null): void {
    this.drawSun(canvas, cx + size * 0.27, cy - size * 0.22, size * 0.09, tint);
    this.drawMountain(canvas, cx, cy, size, tint);
    this.drawGround(canvas, cx, cy, size, tint);
  }

  private createArtworkFilter(settings: EffectSettings): drawing.ImageFilter {
    return drawing.ImageFilter.createBlurImageFilter(settings.imageFilterSigma, settings.imageFilterSigma,
      drawing.TileMode.CLAMP, null);
  }

  private drawSun(canvas: drawing.Canvas, cx: number, cy: number, radius: number,
    tint: drawing.ColorFilter | null): void {
    const brush = new drawing.Brush();
    brush.setAntiAlias(true);
    brush.setColor({
      alpha: 255,
      red: 255,
      green: 205,
      blue: 94
    });
    if (tint !== null) {
      brush.setColorFilter(tint);
    }
    canvas.attachBrush(brush);
    canvas.drawCircle(cx, cy, radius);
    canvas.detachBrush();
  }

  private drawMountain(canvas: drawing.Canvas, cx: number, cy: number, size: number,
    tint: drawing.ColorFilter | null): void {
    const pen = new drawing.Pen();
    pen.setAntiAlias(true);
    pen.setStrokeWidth(size * 0.075);
    pen.setColor({
      alpha: 255,
      red: 32,
      green: 83,
      blue: 91
    });
    if (tint !== null) {
      pen.setColorFilter(tint);
    }
    canvas.attachPen(pen);
    canvas.drawLine(cx - size * 0.39, cy + size * 0.09, cx - size * 0.12, cy - size * 0.12);
    canvas.drawLine(cx - size * 0.12, cy - size * 0.12, cx + size * 0.16, cy + size * 0.10);
    canvas.drawLine(cx - size * 0.02, cy + size * 0.08, cx + size * 0.26, cy - size * 0.07);
    canvas.drawLine(cx + size * 0.26, cy - size * 0.07, cx + size * 0.42, cy + size * 0.10);
    canvas.detachPen();
  }

  private drawGround(canvas: drawing.Canvas, cx: number, cy: number, size: number,
    tint: drawing.ColorFilter | null): void {
    const brush = new drawing.Brush();
    brush.setAntiAlias(true);
    brush.setColor({
      alpha: 255,
      red: 72,
      green: 178,
      blue: 147
    });
    if (tint !== null) {
      brush.setColorFilter(tint);
    }
    canvas.attachBrush(brush);
    canvas.drawRoundRect(this.makeRoundRect(cx - size * 0.42, cy + size * 0.16, cx + size * 0.42,
      cy + size * 0.34, size * 0.06));
    canvas.detachBrush();
  }

  private drawGlow(canvas: drawing.Canvas, cx: number, cy: number, side: number, settings: EffectSettings): void {
    const glowBrush = new drawing.Brush();
    glowBrush.setAntiAlias(true);
    glowBrush.setColor(settings.colors.glow);
    const mask = drawing.MaskFilter.createBlurMaskFilter(drawing.BlurType.OUTER, settings.glowSigma);
    glowBrush.setMaskFilter(mask);
    canvas.attachBrush(glowBrush);
    canvas.drawRoundRect(this.makeRoundRect(cx - side * 0.48, cy - side * 0.40,
      cx + side * 0.48, cy + side * 0.40, side * 0.09));
    canvas.detachBrush();
  }

  private drawReading(canvas: drawing.Canvas, x: number, y: number, size: number, shadow: boolean,
    settings: EffectSettings): void {
    const font = new drawing.Font();
    font.setSize(size);
    const blob = drawing.TextBlob.makeFromString('21C', font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
    const brush = new drawing.Brush();
    brush.setAntiAlias(true);
    brush.setColor(settings.colors.text);
    if (shadow) {
      const shadowLayer = drawing.ShadowLayer.create(4.0, 1.6, 2.4, settings.colors.shadow);
      brush.setShadowLayer(shadowLayer);
    }
    canvas.attachBrush(brush);
    canvas.drawTextBlob(blob, x, y);
    canvas.detachBrush();
  }

  private makeRoundRect(left: number, top: number, right: number, bottom: number, radius: number): drawing.RoundRect {
    const rect: common2D.Rect = {
      left: left,
      top: top,
      right: right,
      bottom: bottom
    };
    return new drawing.RoundRect(rect, radius, radius);
  }
}
