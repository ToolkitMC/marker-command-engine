package com.runtoolkit.mce.item;

import com.runtoolkit.mce.MarkerCommandEngineMod;
import net.fabricmc.fabric.api.item.v1.FabricItemSettings;
import net.fabricmc.fabric.api.itemgroup.v1.FabricItemGroup;
import net.minecraft.item.Item;
import net.minecraft.item.ItemGroup;
import net.minecraft.item.ItemStack;
import net.minecraft.registry.Registries;
import net.minecraft.registry.Registry;
import net.minecraft.text.Text;
import net.minecraft.util.Identifier;

/** Registers MCE utility items and the creative tab. */
public final class MceItems {
    public static final int COOLDOWN_SECONDS = 30;
    public static final int COOLDOWN_TICKS = COOLDOWN_SECONDS * 20;

    public static final Item MCE_CONTROL_PANEL = register("mce_control_panel", new MceActionItem(
            new FabricItemSettings(),
            MceActionItem.ActionType.OPEN_GUI,
            null,
            "marker_command_engine.tooltip.mce_control_panel"
    ));

    public static final Item MCE_HELP_MANUAL = register("mce_help_manual", new MceActionItem(
            new FabricItemSettings(),
            MceActionItem.ActionType.RUN_FUNCTION,
            "function mce:api/util/help",
            "marker_command_engine.tooltip.mce_help_manual"
    ));

    public static final Item MCE_SECURITY_KEY = register("mce_security_key", new MceActionItem(
            new FabricItemSettings(),
            MceActionItem.ActionType.RUN_FUNCTION,
            "function mce:api/security/status",
            "marker_command_engine.tooltip.mce_security_key"
    ));

    public static final Item MCE_QUEUE_CORE = register("mce_queue_core", new MceActionItem(
            new FabricItemSettings(),
            MceActionItem.ActionType.RUN_FUNCTION,
            "function mce:api/queue/run",
            "marker_command_engine.tooltip.mce_queue_core"
    ));

    public static final Item MCE_SCHEDULE_CLOCK = register("mce_schedule_clock", new MceActionItem(
            new FabricItemSettings(),
            MceActionItem.ActionType.RUN_FUNCTION,
            "function mce:api/schedule/clear",
            "marker_command_engine.tooltip.mce_schedule_clock"
    ));

    public static final Item MCE_LOG_READER = register("mce_log_reader", new MceActionItem(
            new FabricItemSettings(),
            MceActionItem.ActionType.RUN_FUNCTION,
            "function mce:api/log/show",
            "marker_command_engine.tooltip.mce_log_reader"
    ));

    public static final Item MCE_CANCEL_CORE = register("mce_cancel_core", new MceActionItem(
            new FabricItemSettings(),
            MceActionItem.ActionType.RUN_FUNCTION,
            "function mce:api/util/cancel",
            "marker_command_engine.tooltip.mce_cancel_core"
    ));

    public static final ItemGroup MCE_ITEM_GROUP = Registry.register(
            Registries.ITEM_GROUP,
            id("mce_items"),
            FabricItemGroup.builder()
                    .displayName(Text.translatable("itemGroup.marker_command_engine.mce_items"))
                    .icon(() -> new ItemStack(MCE_CONTROL_PANEL))
                    .entries((displayContext, entries) -> {
                        entries.add(MCE_CONTROL_PANEL);
                        entries.add(MCE_HELP_MANUAL);
                        entries.add(MCE_SECURITY_KEY);
                        entries.add(MCE_QUEUE_CORE);
                        entries.add(MCE_SCHEDULE_CLOCK);
                        entries.add(MCE_LOG_READER);
                        entries.add(MCE_CANCEL_CORE);
                    })
                    .build()
    );

    private MceItems() {
    }

    public static void register() {
        MarkerCommandEngineMod.LOGGER.info("Registered MCE items and creative tab with {} second cooldown.", COOLDOWN_SECONDS);
    }

    private static Item register(String path, Item item) {
        return Registry.register(Registries.ITEM, id(path), item);
    }

    private static Identifier id(String path) {
        return new Identifier(MarkerCommandEngineMod.MOD_ID, path);
    }
}
