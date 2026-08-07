package com.runtoolkit.mce.client;

import com.runtoolkit.mce.MarkerCommandEngineMod;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import net.minecraft.client.gui.DrawContext;
import net.minecraft.client.gui.screen.Screen;
import net.minecraft.client.gui.widget.ButtonWidget;
import net.minecraft.text.Text;

/** Mod Menu launcher screen for the server-side chest GUI. */
@Environment(EnvType.CLIENT)
final class MceInfoScreen extends Screen {
    private final Screen parent;

    MceInfoScreen(Screen parent) {
        super(Text.translatable("marker_command_engine.modmenu.title"));
        this.parent = parent;
    }

    @Override
    protected void init() {
        int center = this.width / 2;
        addDrawableChild(ButtonWidget.builder(Text.translatable("marker_command_engine.gui.button.open_chest"), button -> {
                    MceClientCommandSender.sendServerCommand("mcegui");
                    close();
                })
                .dimensions(center - 100, this.height - 52, 200, 20)
                .build());

        addDrawableChild(ButtonWidget.builder(Text.translatable("gui.done"), button -> close())
                .dimensions(center - 100, this.height - 28, 200, 20)
                .build());
    }

    @Override
    public void close() {
        if (this.client != null) {
            this.client.setScreen(this.parent);
        }
    }

    @Override
    public void render(DrawContext context, int mouseX, int mouseY, float delta) {
        this.renderBackground(context);

        int center = this.width / 2;
        int y = 24;
        context.drawCenteredTextWithShadow(this.textRenderer, this.title, center, y, 0xFFD700);

        y += 28;
        drawLine(context, Text.translatable("marker_command_engine.modmenu.version", MarkerCommandEngineMod.ENGINE_VERSION), y, 0xFFFFFF);
        y += 14;
        drawLine(context, Text.translatable("marker_command_engine.modmenu.bundle"), y, 0xCFCFCF);
        y += 14;
        drawLine(context, Text.translatable("marker_command_engine.modmenu.fabric_api"), y, 0xA6E3A1);
        y += 14;
        drawLine(context, Text.translatable("marker_command_engine.modmenu.modmenu"), y, 0x89B4FA);
        y += 22;
        drawLine(context, Text.translatable("marker_command_engine.modmenu.command.mcegui"), y, 0xFFFFAA);
        y += 14;
        drawLine(context, Text.translatable("marker_command_engine.modmenu.command.security"), y, 0xFFFFAA);
        y += 14;
        drawLine(context, Text.translatable("marker_command_engine.modmenu.items"), y, 0xFFFFAA);

        super.render(context, mouseX, mouseY, delta);
    }

    private void drawLine(DrawContext context, Text text, int y, int color) {
        context.drawCenteredTextWithShadow(this.textRenderer, text, this.width / 2, y, color);
    }
}
