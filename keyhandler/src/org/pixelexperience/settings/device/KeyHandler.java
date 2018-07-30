package org.pixelexperience.settings.device;

import android.app.ActivityManager;
import android.provider.Settings;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.content.Context;
import android.content.ContentResolver;
import android.view.KeyEvent;
import android.view.InputDevice;

import java.util.List;

import com.android.internal.os.DeviceKeyHandler;
import com.android.internal.util.ArrayUtils;

public class KeyHandler implements DeviceKeyHandler {

    private static final int FP_KEYCODE = KeyEvent.KEYCODE_DPAD_CENTER;
    private static final int FP_SCANCODE = 96;
    private static final String[] FP_EVENTS = new String[]{"fpc_irq_wakeup", "fp-keys", "uinput-fpc", "uinput-goodix"};

    private static final String FP_SHUTTER_PREF_KEY = "pref_fingerprint_capture_key";
    private static final String[] ALLOWED_CAMERA_PACKAGES = new String[]{"com.android.camera"};

    private static ActivityManager am;
    private static PackageManager pm;
    private static ContentResolver resolver;

    public KeyHandler(Context context) {
        am = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        pm = context.getPackageManager();
        resolver = context.getContentResolver();
    }

    public KeyEvent handleKeyEvent(KeyEvent event) {
        String deviceName = "";
        int keyCode = event.getKeyCode();
        int scanCode = event.getScanCode();
        int action = event.getAction();

        if (event.getDeviceId() != -1){
            InputDevice device = InputDevice.getDevice(event.getDeviceId());
            if (device != null){
                deviceName = device.getName();
            }
        }

        if (keyCode == FP_KEYCODE && scanCode == FP_SCANCODE && ArrayUtils.contains(FP_EVENTS, deviceName)){
            if (action != KeyEvent.ACTION_DOWN) {
                return null;
            }
            ActivityInfo runningActivity = getRunningActivityInfo();
            if (runningActivity != null && ArrayUtils.contains(ALLOWED_CAMERA_PACKAGES, runningActivity.packageName)){
                return Settings.Secure.getInt(resolver, FP_SHUTTER_PREF_KEY, 0) == 1 ? event : null;
            }else{
                return null;
            }
        }

        return event;
    }

    private static ActivityInfo getRunningActivityInfo() {
        List<ActivityManager.RunningTaskInfo> tasks = am.getRunningTasks(1);
        if (tasks != null && !tasks.isEmpty()) {
            ActivityManager.RunningTaskInfo top = tasks.get(0);
            try {
                return pm.getActivityInfo(top.topActivity, 0);
            } catch (PackageManager.NameNotFoundException e) {
            }
        }
        return null;
    }

}