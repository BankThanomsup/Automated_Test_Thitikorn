from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

class TouchLibrary:
    @keyword
    def tap_at_coordinates(self, x, y):
        """
        Taps on the screen at the specified coordinates (x, y) using a
        drag gesture. This is a workaround for Appium drivers that do not
        support W3C 'performActions' command directly.

        Args:
        - x: The X coordinate.
        - y: The Y coordinate.
        """
        appium_lib = BuiltIn().get_library_instance('AppiumLibrary')
        driver = appium_lib._current_application()

        x = int(x)
        y = int(y)

        # ใช้คำสั่ง 'mobile: dragGesture' เพื่อจำลองการแตะ
        # การแตะคือการ 'ลาก' จากจุดหนึ่งไปจุดเดิม
        # startX, startY, endX, endY เป็นพารามิเตอร์ที่จำเป็น
        driver.execute_script("mobile: dragGesture", {
            "startX": x,
            "startY": y,
            "endX": x,
            "endY": y,
            "duration": 500 # กำหนดระยะเวลาสั้นๆ เพื่อให้เหมือนการแตะ
        })