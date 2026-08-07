package com.runtoolkit.mce.gui;

import com.runtoolkit.mce.item.MceItems;
import net.minecraft.item.Item;
import net.minecraft.util.Formatting;

/** Fixed actions displayed in the virtual chest GUI. */
public enum MceGuiAction {
    VERSION(10, MceItems.MCE_HELP_MANUAL, "marker_command_engine.chest.version", "function mce:api/util/version", Formatting.AQUA),
    HELP(11, MceItems.MCE_HELP_MANUAL, "marker_command_engine.chest.help", "function mce:api/util/help", Formatting.GREEN),
    SECURITY_STATUS(12, MceItems.MCE_SECURITY_KEY, "marker_command_engine.chest.security_status", "function mce:api/security/status", Formatting.GOLD),
    ALLOW_NEXT(13, MceItems.MCE_SECURITY_KEY, "marker_command_engine.chest.allow_next", "function mce:api/security/allow_next", Formatting.YELLOW),
    STRICT_ON(14, MceItems.MCE_SECURITY_KEY, "marker_command_engine.chest.strict_on", "function mce:api/security/strict_on", Formatting.RED),
    STRICT_OFF(15, MceItems.MCE_SECURITY_KEY, "marker_command_engine.chest.strict_off", "function mce:api/security/strict_off", Formatting.GRAY),
    SECURITY_RESET(16, MceItems.MCE_SECURITY_KEY, "marker_command_engine.chest.security_reset", "function mce:api/security/reset", Formatting.LIGHT_PURPLE),

    QUEUE_RUN(19, MceItems.MCE_QUEUE_CORE, "marker_command_engine.chest.queue_run", "function mce:api/queue/run", Formatting.GREEN),
    QUEUE_CLEAR(20, MceItems.MCE_QUEUE_CORE, "marker_command_engine.chest.queue_clear", "function mce:api/queue/clear", Formatting.RED),
    SCHEDULE_CLEAR(21, MceItems.MCE_SCHEDULE_CLOCK, "marker_command_engine.chest.schedule_clear", "function mce:api/schedule/clear", Formatting.RED),
    LOG_SHOW(22, MceItems.MCE_LOG_READER, "marker_command_engine.chest.log_show", "function mce:api/log/show", Formatting.AQUA),
    LOG_CLEAR(23, MceItems.MCE_LOG_READER, "marker_command_engine.chest.log_clear", "function mce:api/log/clear", Formatting.RED),
    DEBUG_TOGGLE(24, MceItems.MCE_CONTROL_PANEL, "marker_command_engine.chest.debug_toggle", "function mce:api/util/debug_toggle", Formatting.BLUE),
    CANCEL(25, MceItems.MCE_CANCEL_CORE, "marker_command_engine.chest.cancel", "function mce:api/util/cancel", Formatting.DARK_RED);

    public final int slot;
    public final Item cooldownItem;
    public final String titleKey;
    public final String command;
    public final Formatting formatting;

    MceGuiAction(int slot, Item cooldownItem, String titleKey, String command, Formatting formatting) {
        this.slot = slot;
        this.cooldownItem = cooldownItem;
        this.titleKey = titleKey;
        this.command = command;
        this.formatting = formatting;
    }

    public static MceGuiAction bySlot(int slot) {
        for (MceGuiAction action : values()) {
            if (action.slot == slot) {
                return action;
            }
        }
        return null;
    }
}
