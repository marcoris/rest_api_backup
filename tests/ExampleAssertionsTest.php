<?php

class ExampleAssertionsTest extends \PHPUnit\Framework\TestCase
{
    public function testBasic() {
        $this->assertSame("10", "10");
        $this->assertEquals(10, 5 + 5);
    }
}
